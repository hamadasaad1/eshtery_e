import 'package:flutter/material.dart';

const KPrimaryColor = Color(0xFF9C27B0);
const KAccentColor = Color(0xFF7C4DFF);

const KPrimaryLightColor = Color(0xFFFFECDF);

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

const KPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF9C27B0), Color(0xFF7C4DFF)],
);
const KScondaryColor = Color(0xFF979797);
const KTextColor = Color(0xFF757575);
const AinmationDuration = Duration(milliseconds: 200);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "Please Enter your name";
const String kNameShortError = "Your name is too short";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

//For Database
const String KTableCartProduct="cartProduct";
const String KColumnProductId="productId";
const String KColumnName="name";
const String KColumnImage="image";
const String KColumnQuantity="quantity";
const String KColumnPrice="price";
const String KUserSharedPrefs="user";

//this token to access any where app
String KToken;
