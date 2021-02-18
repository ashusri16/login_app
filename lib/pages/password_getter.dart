import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/helpers/sharedpreferences_helper.dart';
import 'package:loginapp/helpers/user_helper.dart';
import 'package:loginapp/pages/home_page.dart';
import 'package:loginapp/pages/local_widgets/custom_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PasswordGetter extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phNumber;
  final String email;
  final String birthDate;
  const PasswordGetter(
      {Key key,
      this.firstName,
      this.lastName,
      this.phNumber,
      this.email,
      this.birthDate})
      : super(key: key);
  @override
  _PasswordGetterState createState() => _PasswordGetterState();
}

class _PasswordGetterState extends State<PasswordGetter> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String password;

  String re_password;
  bool _isEnabled = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Password"),
      ),
      body: Form(
        child: Column(
          children: [
            CustomFormField(
              obscureText: true,
              fieldName: "set password",
              onChanged: (value) {
                password = value;
              },
            ),
            CustomFormField(
              obscureText: true,
              fieldName: "confirm password",
              onChanged: (value) {
                re_password = value;
                if (password == re_password)
                  setState(() {
                    _isEnabled = true;
                  });
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: Text("Continue"),
                  onPressed: () async {
                    if (_isEnabled) {
                      print("pressed");
                      try {
                        UserCredential usercredentail = await Users.createUser(
                            email: widget.email, password: password);
                        await SharedPreferencesHelper.setString(
                            'token', usercredentail.user.uid);
                        await Users.setUserInfo(
                            documentID: usercredentail.user.uid,
                            displayName:
                                "${widget.firstName} ${widget.lastName}",
                            birthDate: widget.birthDate,
                            phNumber: widget.phNumber,
                            email: widget.email);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/homePage', ModalRoute.withName('/'));
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
