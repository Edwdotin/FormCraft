import 'package:flutter/material.dart';
import 'package:form_craft/context/theme_provider.dart';
import 'package:form_craft/models/saved_form.dart';
import 'package:form_craft/pages/create_form_page.dart';
import 'package:form_craft/pages/attend_form_page.dart';
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

  void _navigateToAttendFormPage(int index) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AttendFormPage(form: _savedForms[index]),
      ),
    );

    if (result == true) {
      setState(() {
        _savedForms[index].isSubmitted = true;
      });
    }
  }

  void _deleteForm(int index) {
    setState(() {
      _savedForms.removeAt(index);
    });
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
        title: Row(
          children: [
            Text(
              'FormCraft',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary, // Readable text
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '(${_savedForms.length} forms)',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 16,
              ),
            ),
          ],
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
              padding: const EdgeInsets.all(24.0), // Increased padding
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Fewer cards per row
                crossAxisSpacing: 24.0, // Increased spacing
                mainAxisSpacing: 24.0, // Increased spacing
                childAspectRatio: 1.3, // Adjusted aspect ratio
              ),
              itemCount: _savedForms.length,
              itemBuilder: (context, index) {
                final form = _savedForms[index];
                return InkWell(
                  onTap: form.isSubmitted
                      ? null
                      : () => _navigateToAttendFormPage(index),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    form.title.length > 30
                                        ? '${form.title.substring(0, 30)}...'
                                        : form.title,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    form.description.length > 30
                                        ? '${form.description.substring(0, 30)}...'
                                        : form.description,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.list_alt,
                                    size: 16,
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${form.fields.length} questions',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () => _deleteForm(index),
                            tooltip: 'Delete Form',
                          ),
                        ),
                        if (form.isSubmitted)
                          Positioned(
                            top: 12,
                            left: -50,
                            child: Transform.rotate(
                              angle: -0.785, // -45 degrees
                              child: Container(
                                color: Colors.green,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 4),
                                child: const Text(
                                  'SUBMITTED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
