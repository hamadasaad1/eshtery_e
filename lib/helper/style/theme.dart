import 'package:flutter/material.dart';

import '../../constants.dart';



ThemeData buildThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    accentColor: KAccentColor,
    primaryColor: KPrimaryColor,
    fontFamily: "RobotoCondensed",
    //type of extra font
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
  type: BottomNavigationBarType.shifting,
  elevation: 8,
 showSelectedLabels: false,
  selectedItemColor: KPrimaryColor
    ,
  unselectedItemColor: KAccentColor,
  unselectedIconTheme: IconThemeData(
    color: KAccentColor,
  ),

),

/*    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      enabledBorder: outlineInputBorder(),
      //this to make shape when enter data in form
      focusedBorder: outlineInputBorder(),
      border: outlineInputBorder(),
    )*/
    primarySwatch: Colors.deepPurple,

    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: KTextColor),
    gapPadding: 5,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    actionsIconTheme: IconThemeData(
      color: Colors.black
    ),
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: KTextColor),
    bodyText2: TextStyle(color: KTextColor),

  );
}


class CustomTextStyle {
  static var textFormFieldRegular = TextStyle(
      fontSize: 16,
      fontFamily: "RobotoCondensed",
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static var textFormFieldLight =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w200);

  static var textFormFieldMedium =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w500);

  static var textFormFieldSemiBold =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w600);

  static var textFormFieldBold =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w700);

  static var textFormFieldBlack =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w900);
}