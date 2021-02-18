import 'package:flutter/material.dart';
import 'package:loginapp/pages/dashboard.dart';
import 'package:loginapp/pages/home_page.dart';
import 'package:loginapp/pages/login_page.dart';
import 'package:loginapp/pages/registration.dart';
import 'package:loginapp/pages/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:loginapp/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: customTheme(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => SplashScreen(),
        '/loginPage': (ctx) => LoginPage(),
        '/registration': (ctx) => Registration(),
        '/homePage': (ctx) => HomePage(),
        '/dashBoard': (ctx) => DashBoard(),
      },
    );
  }
}
