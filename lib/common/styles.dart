import 'package:flutter/material.dart';

/*
  Customize Theme
  Colors, Fonts
 */

final Color primaryColor = Color(0xFF002062);
final Color secondaryColor = Color(0xFFFFFFFF);
final Color primaryColorLight = Color(0xFF69CC67);
final Color darkPrimaryColor = Color(0xFF000000);
final Color darkSecondaryColor = Color(0xff64ffda);

final TextTheme customTextTheme = TextTheme(
  headline1: TextStyle(
    fontFamily: 'Merriweather',
    fontSize: 92,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
  ),
  headline2: TextStyle(
    fontFamily: 'Merriweather',
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  ),
  headline3: TextStyle(
    fontFamily: 'Merriweather',
    fontSize: 46,
    fontWeight: FontWeight.w700,
  ),
  headline4: TextStyle(
    fontFamily: 'Merriweather',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
  ),
  headline5: TextStyle(
    fontFamily: 'Merriweather',
    fontSize: 23,
    fontWeight: FontWeight.w700,
  ),
  headline6: TextStyle(
    fontFamily: 'Merriweather',
    fontSize: 19,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
  ),
  subtitle1: TextStyle(
    fontFamily: 'Merriweather',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle2: TextStyle(
    fontFamily: 'Merriweather',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: TextStyle(
    fontFamily: 'Libre Franklin',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: TextStyle(
    fontFamily: 'Libre Franklin',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: TextStyle(
    fontFamily: 'Libre Franklin',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: TextStyle(
    fontFamily: 'Libre Franklin',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: TextStyle(
    fontFamily: 'Libre Franklin',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: secondaryColor,
  primaryColorLight: primaryColorLight,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.white,
  textTheme: customTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: customTextTheme.apply(bodyColor: Colors.white),
    elevation: 0,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: primaryColor,
    textTheme: ButtonTextTheme.accent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: primaryColor,
    selectedLabelStyle:
        customTextTheme.caption.copyWith(fontWeight: FontWeight.w600),
    unselectedItemColor: Colors.grey,
    unselectedLabelStyle:
        customTextTheme.caption.copyWith(fontWeight: FontWeight.w600),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: darkPrimaryColor,
  accentColor: darkSecondaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: customTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: customTextTheme.apply(bodyColor: Colors.white),
    elevation: 0,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: darkSecondaryColor,
    textTheme: ButtonTextTheme.accent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: primaryColorLight,
    selectedLabelStyle:
        customTextTheme.caption.copyWith(fontWeight: FontWeight.w600),
    unselectedItemColor: Colors.grey,
    unselectedLabelStyle:
        customTextTheme.caption.copyWith(fontWeight: FontWeight.w600),
  ),
);
