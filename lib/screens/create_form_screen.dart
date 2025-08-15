import 'package:flutter/material.dart';
import 'package:form_craft/components/custom_appbar.dart';
import 'package:form_craft/components/question_type.dart';

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: 'Untitled form');
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _addQuestion(QuestionType type) {
    print('Add question of type: $type');
    // Here you can add the logic to insert the question into your form state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FormAppBar(
        title: _titleController.text,
        onTitleChanged: (val) => setState(() => _titleController.text = val),
        onSubmissions: () => print('Submissions clicked'),
        onPreview: () => print('Preview clicked'),
        onSave: () => print('Save clicked'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar on the left
          SizedBox(
            width: 250,
            height: 880, // fixed width for sidebar
            child: QuestionTypesSidebar(onAddQuestion: _addQuestion),
          ),

          // Main content area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Text('Build your form here', style: TextStyle(fontSize: 18)),
                  // You can render your dynamic list of questions here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
