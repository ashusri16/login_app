import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginapp/pages/local_widgets/custom_form_field.dart';
import 'package:loginapp/pages/password_getter.dart';
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
  String firstName;
  String lastName;
  String birthDate;
  String phNumber;
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Registration"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomFormField(
                        fieldName: "name",
                        onChanged: (value) {
                          firstName = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomFormField(
                        fieldName: "Surname",
                        onChanged: (value) {
                          lastName = value;
                        },
                      ),
                    ),
                  ],
                ),
                CustomFormField(
                  fieldName: "DD - MM - YYYY (Date of Birth)",
                  onChanged: (value) {
                    birthDate = value;
                  },
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(10),
                    maskFormatter,
                  ],
                ),
                CustomFormField(
                  fieldName: "E-mail",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                CustomFormField(
                  fieldName: "Ph-Number",
                  onChanged: (value) {
                    phNumber = value;
                  },
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(18.0),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
                  child: Text("Complete Registration"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PasswordGetter(
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          birthDate: birthDate,
                          phNumber: phNumber,
                        ),
                      ));
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
