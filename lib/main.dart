import 'package:flutter/material.dart';
import 'package:loginapp/pages/dash_board/dashboard.dart';
import 'package:loginapp/pages/dash_board/page_views/about_us.dart';
import 'package:loginapp/pages/dash_board/page_views/policy.dart';
import 'package:loginapp/pages/dash_board/page_views/profile.dart';
import 'package:loginapp/pages/home_page.dart';
import 'package:loginapp/pages/login_page/login_page.dart';
import 'package:loginapp/pages/otp_verification.dart';
import 'package:loginapp/pages/registration.dart';
import 'package:loginapp/pages/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:loginapp/providers/size_provider.dart';
import 'package:loginapp/utils/theme.dart';
import 'package:provider/provider.dart';

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
        '/aboutUs': (ctx) => AboutUs(),
        '/policy': (ctx) => Policy(),
      },
    );
  }
}
