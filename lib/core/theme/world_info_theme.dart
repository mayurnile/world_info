import 'package:flutter/material.dart';

class WorldInfoTheme {
  //colors
  static const Color PRIMARY_COLOR = Color(0xFF45BFE5);
  static const Color SECONDARY_COLOR = Color(0xFFFFFFFF);
  static const Color FONT_DARK_COLOR = Color(0xFF333333);
  static const Color FONT_LIGHT_COLOR = Color(0XFF9AACB1);

  //seven colors of seven countries
  static const List<Color> regionsColors = [
    Color(0xFFF59C2E),
    Color(0xFF8AA7C9),
    Color(0xFFC0501C),
    Color(0xFF7CC597),
    Color(0xFF8E629E),
    Color(0xFFF57E6A),
    Color(0xFF1F997B),
  ];

  static BoxDecoration countryDetailCardDecoration = BoxDecoration(
    border: Border.all(
      color: WorldInfoTheme.FONT_LIGHT_COLOR,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(12.0),
  );

  static ThemeData worldInfoThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: PRIMARY_COLOR,
    accentColor: PRIMARY_COLOR,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: FONT_DARK_COLOR,
      ),
      headline2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: FONT_LIGHT_COLOR,
      ),
      headline3: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: FONT_DARK_COLOR,
      ),
      headline4: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: FONT_DARK_COLOR,
      ),
      headline5: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: FONT_LIGHT_COLOR,
      ),
      headline6: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: FONT_DARK_COLOR,
      ),
    ),
  );
}
