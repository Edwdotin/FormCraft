import 'package:flutter/material.dart';
import 'package:form_craft/context/theme_provider.dart';
import 'package:form_craft/pages/create_form_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(
          context,
        ).scaffoldBackgroundColor, // Matches body
        elevation: 0, // No shadow
        title: Text(
          'FormCraft',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary, // Readable text
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text(
                "Create Form",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreateFormPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello Wold!', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
