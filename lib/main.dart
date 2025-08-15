// main.dart
import 'package:flutter/material.dart';
import 'package:form_craft/context/theme_provider.dart';
import 'package:form_craft/pages/home_page.dart';
import 'package:form_craft/themes/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // 👈 This hides the debug banner

      title: 'Form Craft',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier.themeMode, // Switches automatically
      home: HomePage(),
    );
  }
}
