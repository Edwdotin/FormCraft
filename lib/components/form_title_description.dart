import 'package:flutter/material.dart';

class FormTitleDescription extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const FormTitleDescription({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: const InputDecoration(
                labelText: 'Form Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Form Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
