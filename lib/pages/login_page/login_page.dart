import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/helpers/newtork_helper.dart';
import 'package:loginapp/helpers/sharedpreferences_helper.dart';
import 'package:loginapp/helpers/user_helper.dart';
import 'package:loginapp/pages/home_page.dart';
import 'package:loginapp/pages/local_widgets/custom_form_field.dart';
import 'package:loginapp/pages/local_widgets/scaffold_theme.dart';
import 'package:loginapp/pages/registration.dart';
import 'package:loginapp/utils/colors.dart';

String email = "";
String password = "";
bool isLoading = false;
final _formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ScaffoldTheme(
              pageTitle: "LOGIN",
              buttonTitle: "Login",
              isLoading: isLoading,
              children: [
                CustomFormField(
                  prefixIcon: Icon(Icons.person),
                  fieldName: "email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                CustomFormField(
                  fieldName: "Password",
                  prefixIcon: Icon(Icons.lock_rounded),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                )
              ],
              onPressed: () async {
                if (email != "" && password != "") {
                  setState(() {
                    isLoading = true;
                  });
                  await Connection.isConnected().then((value) async {
                    if (value) {
                      try {
                        UserCredential userCredential = await Users.authUser(
                            email: email, password: password);

                        if (userCredential == null) {
                        } else {
                          print(userCredential.user);
                          await SharedPreferencesHelper.setString(
                              'token', userCredential.user.uid);
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/homePage', ModalRoute.withName('/'));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          _showUserErrorDialogue(
                              context, 'No user found for that email');
                        } else if (e.code == 'wrong-password') {
                          _showUserErrorDialogue(
                              context, 'Wrong password provided for that user');
                        }
                      }
                    } else {
                      _showUserErrorDialogue(
                          context, "No Internet Connection, Please try again");
                    }
                  });
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Please enter credentials"),
                  ));
                }
              },
              bottomLink: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  GestureDetector(
                    child: Text(
                      "SIGN UP",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/registration');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showUserErrorDialogue(BuildContext context, String errorText) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.black)),
          content: Text(
            errorText,
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: [
            Expanded(
              child: FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: MyColors.primaryColor),
                ),
                onPressed: () {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: 0.0),
        );
      },
    );
  }
}
