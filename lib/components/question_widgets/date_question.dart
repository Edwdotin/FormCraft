import 'package:flutter/material.dart';
import 'package:form_craft/models/form_field.dart';

class DateQuestion extends StatelessWidget {
  final FormFieldModel field;
  final VoidCallback onDelete;
  final ValueChanged<String> onChanged;

  const DateQuestion({
    super.key,
    required this.field,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: field.question,
                    onChanged: onChanged,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            TextButton.icon(
              icon: const Icon(Icons.calendar_today),
              label: const Text('Select Date'),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
