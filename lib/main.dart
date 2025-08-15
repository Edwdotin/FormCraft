import 'package:flutter/material.dart';
import 'package:form_craft/screens/home_screen.dart';
import 'themes/theme.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: HomeScreen(),
    ),
  );
}
