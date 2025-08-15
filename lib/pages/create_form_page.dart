import 'package:flutter/material.dart';
import 'package:form_craft/components/question_type.dart';
import 'package:form_craft/utils/question_type.dart';

class CreateFormPage extends StatefulWidget {
  const CreateFormPage({super.key});

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  late TextEditingController _titleController;
  // bool _isSidebarVisible = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: 'Untitled Form');
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  // void _toggleSidebar() {
  //   setState(() {
  //     _isSidebarVisible = !_isSidebarVisible;
  //   });
  // }

  void _addQuestion(QuestionType type) {
    // TODO: Implement question adding logic
    print('Adding question of type: \$type');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: TextField(
          controller: _titleController,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.add_circle_outline),
          //   onPressed: _toggleSidebar,
          //   tooltip: 'Add Question',
          // ),
          TextButton.icon(
            icon: const Icon(Icons.visibility, size: 18),
            label: const Text("Preview"),
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.save, size: 18, color: Colors.white),
            label: const Text(
              "Save",
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
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          const Center(child: Text('This is the form creation page.')),

          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: 250,
              child: QuestionTypesSidebar(onAddQuestion: _addQuestion),
            ),
          ),
        ],
      ),
    );
  }
}
