import 'package:flutter/material.dart';
import 'package:form_craft/models/form_field.dart';

typedef OptionChangedCallback = void Function(int, String);

class DropdownQuestion extends StatelessWidget {
  final FormFieldModel field;
  final VoidCallback onDelete;
  final ValueChanged<String> onChanged;
  final ValueChanged<int> onRemoveOption;
  final OptionChangedCallback onOptionChanged;
  final VoidCallback onAddOption;

  const DropdownQuestion({
    super.key,
    required this.field,
    required this.onDelete,
    required this.onChanged,
    required this.onRemoveOption,
    required this.onOptionChanged,
    required this.onAddOption,
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
            for (int i = 0; i < field.options.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: field.options[i],
                      onChanged: (value) => onOptionChanged(i, value),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => onRemoveOption(i),
                  ),
                ],
              ),
            TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Option'),
              onPressed: onAddOption,
            ),
          ],
        ),
      ),
    );
  }
}
