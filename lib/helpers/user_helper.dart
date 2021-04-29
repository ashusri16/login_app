import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginapp/helpers/sharedpreferences_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';

class Users {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static CollectionReference get users =>
      FirebaseFirestore.instance.collection('users');
  static firebase_storage.FirebaseStorage get storage =>
      firebase_storage.FirebaseStorage.instance;
  static String verificationId = "null";

  static UserCredential userCredential;

  static Future<UserCredential> createUser(
      {String email, String password}) async {
    userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

  static Future<UserCredential> authUser(
      {String email, String password}) async {
    userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<void> setUserInfo(
      {String documentID,
      String displayName,
      String phNumber,
      String email}) async {
    await users.doc(documentID).set({
      "displayName": displayName,
      "profileUrl": "notAdded",
      "email": email,
      "phNumber": phNumber,
    });
  }

  static Future<DocumentSnapshot> getUserInfo({String documentID}) async {
    DocumentSnapshot currentUser = await users.doc(documentID).get();
    return currentUser;
  }

  static Future<void> verifyNumber(String phNumber) async {
    auth.verifyPhoneNumber(
        phoneNumber: "+91" + phNumber,
        timeout: Duration(seconds: 5),
        codeSent: (String verification, int resendToken) {
          print(verification);
          verificationId = verification;
          print(resendToken);
        },
        codeAutoRetrievalTimeout: (String viD) {
          print("auto");
          print(viD);
        },
        verificationFailed: (FirebaseAuthException e) {
          print("verification failed");
          print(e);
        },
        verificationCompleted: (PhoneAuthCredential pc) {
          print("verified");
        });
  }

  static Future<void> verifyOtp(BuildContext context, String smsCode) async {
    print("inside verif Opt");
    print(verificationId);
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      await auth.currentUser.updatePhoneNumber(authCredential);
      Navigator.of(context).pushNamed('/');
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-verification-code")
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Wrong otp, Please try again"),
        ));
      else {
        print(e.code);
      }
    }
    print(auth.currentUser.phoneNumber);
  }

  static Future<void> logOut(BuildContext context) async {
    await SharedPreferencesHelper.clearPrefs();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/loginPage', ModalRoute.withName('/dashBoard'));
  }

  static Future<void> addProfilePicture(
      BuildContext context, PickedFile photo) async {}
}
