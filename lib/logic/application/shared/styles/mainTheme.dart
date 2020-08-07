import 'package:flutter/material.dart';

class MainTheme {
  static Color _primaryColor = Colors.white;
  static Color _accentColor = Colors.black;
  static Color _mainTextColor = Colors.black;

  static String _fontFamily = 'marvel';

  static ThemeData marvelAppTheme = ThemeData(
      primaryColor: _primaryColor,
      accentColor: _accentColor,
      textTheme: _textTheme);

  static TextTheme _textTheme = TextTheme(
      caption: _caption,
      bodyText1: _bodyText1,
      bodyText2: _bodyText2,
      headline1: _headLine1,
      headline2: _headLine2,
      headline3: _headLine3,
      headline4: _headLine4,
      headline5: _headLine5,
      headline6: _headLine6);

  static TextStyle _caption =
      TextStyle(fontFamily: _fontFamily, color: _mainTextColor, fontSize: 10);

  static TextStyle _bodyText1 =
      TextStyle(fontFamily: _fontFamily, color: _mainTextColor, fontSize: 15);

  static TextStyle _bodyText2 =
      TextStyle(fontFamily: _fontFamily, color: _mainTextColor, fontSize: 17);

  static TextStyle _headLine1 =
      TextStyle(fontFamily: _fontFamily, color: _mainTextColor, fontSize: 22);

  static TextStyle _headLine2 =
      TextStyle(fontFamily: _fontFamily, color: _mainTextColor, fontSize: 20);

  static TextStyle _headLine3 =
      TextStyle(fontFamily: _fontFamily, color: _mainTextColor, fontSize: 25);

  static TextStyle _headLine4 =
      TextStyle(fontFamily: _fontFamily, color: _mainTextColor, fontSize: 30);

  static TextStyle _headLine5 =
      TextStyle(fontFamily: _fontFamily, color: _mainTextColor, fontSize: 35);

  static TextStyle _headLine6 =
      TextStyle(fontFamily: _fontFamily, color: _mainTextColor, fontSize: 20);
}
