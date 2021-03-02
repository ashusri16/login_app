import 'package:flutter/material.dart';
import 'package:loginapp/utils/colors.dart';

ThemeData customTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      //title
      headline1: base.headline1.copyWith(
        fontSize: 36,
        fontFamily: 'Opensans',
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      //labelStyle
      headline2: base.headline2.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Opensans',
        color: MyColors.greyLight,
      ),
      //button style
      headline3: base.headline3.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Opensans',
        color: Colors.white,
      ),
      //bottom link inline span 1
      headline4: base.headline4.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Opensans',
        color: Colors.grey[500],
      ),
      //bottom link inline span 2
      headline5: base.headline5.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Opensans',
        color: Colors.black,
      ),
      //appBar title
      headline6: base.headline6.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        fontFamily: 'Opensans',
        color: Colors.white,
      ),
      subtitle1: base.subtitle1.copyWith(
        fontFamily: 'Opensans',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: MyColors.greyDark,
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
    primaryColor: MyColors.primaryColor,
    accentColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
      buttonColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
  );
}
