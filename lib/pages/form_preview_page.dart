import 'package:flutter/material.dart';
import 'package:form_craft/models/form_field.dart';
import 'package:form_craft/utils/question_type.dart';

class FormPreviewPage extends StatelessWidget {
  final String title;
  final String description;
  final List<FormFieldModel> fields;

  const FormPreviewPage({
    super.key,
    required this.title,
    required this.description,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            for (int i = 0; i < fields.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${i + 1}. ${fields[i].question}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    _buildPreviewWidget(fields[i]),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewWidget(FormFieldModel field) {
    switch (field.type) {
      case QuestionType.shortText:
        return const TextField(
          decoration: InputDecoration(
            hintText: 'Your answer',
            border: OutlineInputBorder(),
          ),
        );
      case QuestionType.longText:
        return const TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Your answer',
            border: OutlineInputBorder(),
          ),
        );
      case QuestionType.checkbox:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: field.options
              .map((option) => Row(
                    children: [
                      Checkbox(value: false, onChanged: (val) {}),
                      Text(option),
                    ],
                  ))
              .toList(),
        );
      case QuestionType.multipleChoice:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: field.options
              .map((option) => Row(
                    children: [
                      Radio(value: option, groupValue: null, onChanged: (val) {}),
                      Text(option),
                    ],
                  ))
              .toList(),
        );
      case QuestionType.dropdown:
        return DropdownButtonFormField<String>(
          items: field.options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        );
      case QuestionType.date:
        return TextButton.icon(
          icon: const Icon(Icons.calendar_today),
          label: const Text('Select Date'),
          onPressed: () {},
        );
      default:
        return Container();
    }
  }
}
