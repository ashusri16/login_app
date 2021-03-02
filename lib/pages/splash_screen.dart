import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/helpers/sharedpreferences_helper.dart';
import 'package:loginapp/pages/home_page.dart';
import 'package:loginapp/pages/registration.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Registration();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          print("connection done");
          handleLogin();
          return Scaffold(
            body: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return HomePage();
      },
    );
  }

  void handleLogin() async {
    String token = await SharedPreferencesHelper.getString('token');
    if (token == null) {
      print("token null");
      Navigator.of(context).popAndPushNamed('/loginPage');
    } else {
      print(token);
      Navigator.of(context).popAndPushNamed('/homePage');
    }
  }
}
