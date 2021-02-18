import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginapp/helpers/sharedpreferences_helper.dart';
import 'package:loginapp/pages/login_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Users {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static CollectionReference get users =>
      FirebaseFirestore.instance.collection('users');
  static firebase_storage.FirebaseStorage get storage =>
      firebase_storage.FirebaseStorage.instance;

  static Future<UserCredential> createUser(
      {String email, String password}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

  static Future<UserCredential> authUser(
      {String email, String password}) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<void> setUserInfo(
      {String documentID,
      String displayName,
      String birthDate,
      String phNumber,
      String email}) async {
    await users.doc(documentID).set({
      "displayName": displayName,
      "birthDate": birthDate,
      "email": email,
      "phNumber": phNumber,
    });
  }

  static Future<DocumentSnapshot> getUserInfo({String documentID}) async {
    DocumentSnapshot currentUser = await users.doc(documentID).get();
    return currentUser;
  }

  static Future<void> logOut(BuildContext context) async {
    await SharedPreferencesHelper.clearPrefs();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/loginPage', ModalRoute.withName('/dashBoard'));
  }

  static Future<void> addProfilePicture(
      BuildContext context, PickedFile photo) async {}
}
