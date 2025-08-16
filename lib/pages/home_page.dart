import 'package:flutter/material.dart';
import 'package:form_craft/context/theme_provider.dart';
import 'package:form_craft/models/saved_form.dart';
import 'package:form_craft/pages/create_form_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<SavedForm> _savedForms = [];

  void _navigateToCreateFormPage() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CreateFormPage()),
    );

    if (result != null && result is SavedForm) {
      setState(() {
        _savedForms.add(result);
      });
    }
  }

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
              onPressed: _navigateToCreateFormPage,
            ),
          ),
        ],
      ),
      body: _savedForms.isEmpty
          ? const Center(
              child: Text('No forms created yet.', style: TextStyle(fontSize: 20)),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: _savedForms.length,
              itemBuilder: (context, index) {
                final form = _savedForms[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          form.title,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text('${form.fields.length} questions'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
