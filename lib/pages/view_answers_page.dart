import 'package:flutter/material.dart';
import 'package:form_craft/models/form_field.dart';
import 'package:form_craft/models/saved_form.dart';
import 'package:form_craft/utils/question_type.dart';

class ViewAnswersPage extends StatelessWidget {
  final SavedForm form;

  const ViewAnswersPage({super.key, required this.form});

  Widget _buildAnswerDisplay(FormFieldModel field, dynamic answer) {
    if (answer == null) {
      return const Text('No answer provided', style: TextStyle(fontStyle: FontStyle.italic));
    }

    switch (field.type) {
      case QuestionType.shortText:
      case QuestionType.longText:
      case QuestionType.multipleChoice:
      case QuestionType.dropdown:
        return Text(answer.toString(), style: const TextStyle(fontSize: 16));
      case QuestionType.checkbox:
        if (answer is List) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: answer.map((e) => Text('- ${e.toString()}', style: const TextStyle(fontSize: 16))).toList(),
          );
        }
        return const Text('Invalid answer format', style: TextStyle(color: Colors.red));
      case QuestionType.date:
        if (answer is DateTime) {
          return Text(answer.toLocal().toIso8601String().split('T')[0], style: const TextStyle(fontSize: 16));
        }
        return const Text('Invalid answer format', style: TextStyle(color: Colors.red));
      default:
        return const Text('Unsupported question type', style: TextStyle(color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Answers'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              form.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              form.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(height: 48),
            ...form.fields.map((field) {
              final answer = form.answers[field.id];
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      field.question,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    _buildAnswerDisplay(field, answer),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
