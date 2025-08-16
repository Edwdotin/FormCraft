import 'package:flutter/material.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final int id;
  final VoidCallback onDelete;

  const MultipleChoiceQuestion({
    super.key,
    required this.id,
    required this.onDelete,
  });

  @override
  State<MultipleChoiceQuestion> createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  final List<String> _options = ['Option 1'];
  final TextEditingController _optionController = TextEditingController();
  String? _groupValue = 'Option 1';

  void _addOption() {
    if (_optionController.text.isNotEmpty) {
      setState(() {
        _options.add(_optionController.text);
        _optionController.clear();
      });
    }
  }

  void _removeOption(int index) {
    setState(() {
      _options.removeAt(index);
    });
  }

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
            ListView.builder(
              shrinkWrap: true,
              itemCount: _options.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Radio<String>(
                      value: _options[index],
                      groupValue: _groupValue,
                      onChanged: (String? value) {
                        setState(() {
                          _groupValue = value;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(_options[index]),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _removeOption(index),
                    ),
                  ],
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _optionController,
                    decoration: const InputDecoration(
                      hintText: 'Add option',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addOption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
