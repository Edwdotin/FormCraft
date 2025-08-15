import 'package:flutter/material.dart';

final Color kPrimaryDark = const Color.fromRGBO(0, 64, 48, 1);
final Color kPrimaryMedium = const Color.fromRGBO(74, 151, 130, 1);
final Color kNeutralLight = const Color.fromRGBO(220, 208, 168, 1);
final Color kBackgroundLight = const Color.fromRGBO(255, 249, 229, 1);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kPrimaryDark,
  scaffoldBackgroundColor: kBackgroundLight,
  colorScheme: ColorScheme.light(
    primary: kPrimaryDark,
    secondary: kPrimaryMedium,
    surface: kNeutralLight,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: 'Roboto', fontSize: 16),
    bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 14),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kPrimaryMedium,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: ColorScheme.dark(
    primary: kPrimaryMedium,
    secondary: kNeutralLight,
    surface: const Color(0xFF1E1E1E),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: 'Roboto', fontSize: 16),
    bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 14),
  ),
);
