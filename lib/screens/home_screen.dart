import 'package:flutter/material.dart';
import 'package:form_craft/themes/theme.dart';
import 'package:form_craft/screens/create_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text(
          "FormCraft",
          style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreateFormScreen()),
                );
              },
              icon: Icon(Icons.add, size: 20),
              label: Text("Create Form"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // rectangle corners
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text("Welcome to FormCraft", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
