import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginapp/helpers/newtork_helper.dart';
import 'package:loginapp/helpers/sharedpreferences_helper.dart';
import 'package:loginapp/helpers/user_helper.dart';
import 'package:loginapp/pages/local_widgets/custom_form_field.dart';
import 'package:loginapp/pages/local_widgets/scaffold_theme.dart';
import 'package:loginapp/pages/otp_verification.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')});
  String name;
  String birthDate;
  String phNumber;
  String email;
  String password;
  String repassword;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ScaffoldTheme(
              isLoading: isLoading,
              pageTitle: "SIGN UP",
              children: [
                CustomFormField(
                  fieldName: "Name",
                  prefixIcon: Icon(Icons.person),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                CustomFormField(
                  prefixIcon: Icon(Icons.mail),
                  fieldName: "E-mail",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                CustomFormField(
                  prefixIcon: Icon(Icons.phone),
                  fieldName: "Ph-Number",
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    phNumber = value;
                  },
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                CustomFormField(
                  fieldName: "Password",
                  prefixIcon: Icon(Icons.lock),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                CustomFormField(
                  fieldName: "Confirm Password",
                  prefixIcon: Icon(Icons.lock),
                  obscureText: true,
                  onChanged: (value) {
                    repassword = value;
                  },
                ),
              ],
              buttonTitle: "Sign Up",
              onPressed: () async {
                if (name == null ||
                    phNumber == null ||
                    email == null ||
                    password == null ||
                    repassword == null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Please fill all fields"),
                  ));
                } else if (password != repassword) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("passwords don't match, Please try again"),
                  ));
                } else if (phNumber.length != 10) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Please enter a valid Phone number"),
                  ));
                } else {
                  await Connection.isConnected().then((value) async {
                    if (value) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        UserCredential usercredentail = await Users.createUser(
                            email: email, password: password);
                        await SharedPreferencesHelper.setString(
                            'token', usercredentail.user.uid);
                        await Users.setUserInfo(
                            documentID: usercredentail.user.uid,
                            displayName: name,
                            phNumber: phNumber,
                            email: email);
                        await Users.verifyNumber(phNumber);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OTPVerification(
                                  phNumber: phNumber,
                                )));
                      } catch (e) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                        ));
                      }
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("No Network Connection"),
                      ));
                    }
                  });
                }
              },
              bottomLink: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  GestureDetector(
                    child: Text(
                      "LOGIN",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/loginPage');
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
}
