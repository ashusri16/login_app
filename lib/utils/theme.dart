import 'package:flutter/material.dart';

ThemeData customTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1.copyWith(
        fontSize: 20,
        fontFamily: 'Opensans',
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline2: base.headline2.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        fontFamily: 'Opensans',
        color: Colors.grey[500],
      ),
      headline3: base.headline3.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        fontFamily: 'Opensans',
        color: Colors.grey[500],
      ),
      headline4: base.headline4.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Opensans',
        color: Colors.grey[400],
      ),
      headline5: base.headline5.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Opensans',
        color: Colors.grey[300],
      ),
      headline6: base.headline6.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Opensans',
        color: Colors.grey[300],
      ),
      subtitle1: base.subtitle1.copyWith(
        fontFamily: 'Opensans',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.grey[300],
      ),
      bodyText1: base.bodyText1.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Opensans',
        color: Colors.white,
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: Color(0xFF0eb5fd),
    accentColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
      buttonColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    ),
    highlightColor: Color(0xFFa9e5ff),
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );
}
