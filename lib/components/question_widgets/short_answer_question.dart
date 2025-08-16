
import 'package:flutter/material.dart';
import 'package:form_craft/models/form_field.dart';

class ShortAnswerQuestion extends StatelessWidget {
  final FormFieldModel field;
  final VoidCallback onDelete;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> onRequiredChanged;

  const ShortAnswerQuestion({
    super.key,
    required this.field,
    required this.onDelete,
    required this.onChanged,
    required this.onRequiredChanged,
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
            const TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Short answer text',
                border: OutlineInputBorder(),
              ),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Required'),
              value: field.isRequired,
              onChanged: onRequiredChanged,
            ),
          ],
        ),
      ),
    );
  }
}
