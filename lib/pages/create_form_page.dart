import 'package:flutter/material.dart';
import 'package:form_craft/components/form_title_description.dart';
import 'package:form_craft/components/question_type.dart';
import 'package:form_craft/components/question_widgets/checkbox_question.dart';
import 'package:form_craft/components/question_widgets/date_question.dart';
import 'package:form_craft/components/question_widgets/dropdown_question.dart';
import 'package:form_craft/components/question_widgets/long_answer_question.dart';
import 'package:form_craft/components/question_widgets/multiple_choice_question.dart';
import 'package:form_craft/components/question_widgets/short_answer_question.dart';
import 'package:form_craft/utils/question_type.dart';

class CreateFormPage extends StatefulWidget {
  const CreateFormPage({super.key});

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  late TextEditingController _titleController;
  final List<Widget> _questionWidgets = [];
  int _nextId = 0;

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

  void _addQuestion(QuestionType type) {
    setState(() {
      final id = _nextId++;
      switch (type) {
        case QuestionType.shortText:
          _questionWidgets.add(ShortAnswerQuestion(
            key: ValueKey(id),
            id: id,
            onDelete: () => _deleteQuestion(id),
          ));
          break;
        case QuestionType.longText:
          _questionWidgets.add(LongAnswerQuestion(
            key: ValueKey(id),
            id: id,
            onDelete: () => _deleteQuestion(id),
          ));
          break;
        case QuestionType.checkbox:
          _questionWidgets.add(CheckboxQuestion(
            key: ValueKey(id),
            id: id,
            onDelete: () => _deleteQuestion(id),
          ));
          break;
        case QuestionType.multipleChoice:
          _questionWidgets.add(MultipleChoiceQuestion(
            key: ValueKey(id),
            id: id,
            onDelete: () => _deleteQuestion(id),
          ));
          break;
        case QuestionType.dropdown:
          _questionWidgets.add(DropdownQuestion(
            key: ValueKey(id),
            id: id,
            onDelete: () => _deleteQuestion(id),
          ));
          break;
        case QuestionType.date:
          _questionWidgets.add(DateQuestion(
            key: ValueKey(id),
            id: id,
            onDelete: () => _deleteQuestion(id),
          ));
          break;
        default:
          break;
      }
    });
  }

  void _deleteQuestion(int id) {
    setState(() {
      _questionWidgets.removeWhere((widget) => (widget.key as ValueKey).value == id);
    });
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250,
            child: QuestionTypesSidebar(onAddQuestion: _addQuestion),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    FormTitleDescription(titleController: _titleController),
                    for (int i = 0; i < _questionWidgets.length; i++)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${i + 1}.'),
                          const SizedBox(width: 8),
                          Expanded(child: _questionWidgets[i]),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
