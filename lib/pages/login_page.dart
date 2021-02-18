import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginapp/helpers/sharedpreferences_helper.dart';
import 'package:loginapp/helpers/user_helper.dart';
import 'package:loginapp/pages/home_page.dart';
import 'package:loginapp/pages/registration.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: "E-Mail"),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) return "Please enter valid E-mail";
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Password"),
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 6)
                        return "Please enter valid password";
                      return null;
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      UserCredential userCredential = await Users.authUser(
                          email: email, password: password);

                      if (userCredential == null) {
                      } else {
                        print(userCredential.user);
                        await SharedPreferencesHelper.setString(
                            'token', userCredential.user.uid);
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
                  }
                },
                child: _isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Text("Continue"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("New User?"),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/registration');
              },
              child: Text("Register new user"),
            ),
          ],
        ),
      ),
    );
  }

  _showUserErrorDialogue(BuildContext context, String errorText) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorText),
          actions: [
            Expanded(
              child: FlatButton(
                child: Text("OK"),
                onPressed: () {
                  setState(() {
                    _isLoading = false;
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
