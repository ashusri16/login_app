import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/helpers/newtork_helper.dart';
import 'package:loginapp/helpers/sharedpreferences_helper.dart';
import 'package:loginapp/helpers/user_helper.dart';

import 'dash_board/dashboard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          return DashBoard(
            snapshot: snapShot,
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Future<DocumentSnapshot> _getUserData() async {
    bool isConnected = await Connection.isConnected();
    if (isConnected) {
      String token = await SharedPreferencesHelper.getString('token');
      DocumentSnapshot userData = await Users.getUserInfo(documentID: token);
      return userData;
    } else {
      print("No notwork available");
    }
  }
}
