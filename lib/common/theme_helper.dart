import 'package:flutter/material.dart';

class ThemeHelper{
  static Color primaryColor = const Color(0xff6758C0);
  static Color accentColor = const Color(0xff20aebe);
  static Color shadowColor = const Color(0xffa2a6af);

  static ThemeData getThemeData(){
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
      )
    );
  }

  static roundBoxDeco({Color color = Colors.white, double radius = 15}) {
    return BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}