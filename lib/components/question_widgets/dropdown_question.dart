import 'package:flutter/material.dart';

class DropdownQuestion extends StatefulWidget {
  final int id;
  final VoidCallback onDelete;

  const DropdownQuestion({
    super.key,
    required this.id,
    required this.onDelete,
  });

  @override
  State<DropdownQuestion> createState() => _DropdownQuestionState();
}

class _DropdownQuestionState extends State<DropdownQuestion> {
  final List<String> _options = ['Option 1', 'Option 2', 'Option 3'];
  String? _selectedValue = 'Option 1';

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
                    initialValue: 'Question',
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
                  onPressed: widget.onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            DropdownButton<String>(
              value: _selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
              },
              items: _options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
