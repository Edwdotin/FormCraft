import 'package:flutter/material.dart';

// Primary color
const primaryGreen = Color.fromARGB(255, 16, 75, 19);

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryGreen),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: primaryGreen, // text/icon color
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
);
