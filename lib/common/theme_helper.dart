import 'package:flutter/material.dart';

class ThemeHelper {
  static Color primaryColor = const Color(0xfffbce7b);
  static Color accentColor = const Color(0xff8d5ac4);
  static Color shadowColor = const Color(0xfffbfadd);

  static ThemeData getThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
      ),
      textTheme: TextTheme(
        headline3: TextStyle(
          color: accentColor,
          fontFamily: 'Baloo',
        ),
        headline5: const TextStyle(
          color: Colors.white,
          fontFamily: 'Baloo',
        ),
      ),
    );
  }

  static roundBoxDeco({Color color = Colors.white, double radius = 15}) {
    return BoxDecoration(
        color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
