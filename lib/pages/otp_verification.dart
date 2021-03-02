import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginapp/helpers/user_helper.dart';
import 'package:loginapp/pages/local_widgets/custom_form_field.dart';
import 'package:loginapp/pages/local_widgets/scaffold_theme.dart';
import 'package:loginapp/utils/colors.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPVerification extends StatefulWidget {
  final String phNumber;

  const OTPVerification({Key key, this.phNumber}) : super(key: key);
  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  String smsCode;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => Container(
            child: ScaffoldTheme(
          isLoading: false,
          children: [
            Text(
              "Enter OTP sent to ${widget.phNumber}",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: MyColors.greyDark),
            ),
            PinFieldAutoFill(
              codeLength: 6,
              autofocus: false,
              onCodeChanged: (value) {
                smsCode = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    color: MyColors.primaryColor,
                  ),
                  Text(
                    "Edit number",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: MyColors.primaryColor),
                  ),
                ],
              ),
              onPressed: () async {
                String newNum;
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AspectRatio(
                        aspectRatio: 1,
                        child: AlertDialog(
                          title: Text(
                            "Enter Phone Number",
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                          content: Container(
                            height: 100,
                            child: Center(
                              child: CustomFormField(
                                fieldName: "",
                                prefixIcon: Icon(Icons.phone_android),
                                onChanged: (value) {
                                  newNum = value;
                                  print(newNum);
                                },
                                inputFormatter: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          actionsPadding:
                              EdgeInsets.symmetric(horizontal: 12.0),
                          actions: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 50,
                                width: 150,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(31)),
                                  child: Text("Update"),
                                  color: MyColors.primaryColor,
                                  onPressed: () async {
                                    await Users.verifyNumber(newNum);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            OTPVerification(
                                          phNumber: newNum,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
            )
          ],
          pageTitle: "OTP verification",
          buttonTitle: "Continue",
          onPressed: () async {
            setState(() {
              loading = true;
            });
            await Users.verifyOtp(context, smsCode);
            setState(() {
              loading = false;
            });
          },
        )),
      ),
    );
  }
}
