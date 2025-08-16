import 'package:flutter/material.dart';
import 'package:form_craft/components/form_title_description.dart';
import 'package:form_craft/components/question_type.dart';
import 'package:form_craft/components/question_widgets/checkbox_question.dart';
import 'package:form_craft/components/question_widgets/date_question.dart';
import 'package:form_craft/components/question_widgets/dropdown_question.dart';
import 'package:form_craft/components/question_widgets/long_answer_question.dart';
import 'package:form_craft/components/question_widgets/multiple_choice_question.dart';
import 'package:form_craft/components/question_widgets/short_answer_question.dart';
import 'package:form_craft/models/form_field.dart';
import 'package:form_craft/models/saved_form.dart';
import 'package:form_craft/pages/form_preview_page.dart';
import 'package:form_craft/utils/question_type.dart';

class CreateFormPage extends StatefulWidget {
  const CreateFormPage({super.key});

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  final List<FormFieldModel> _fields = [];
  int _nextId = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: 'Untitled Form');
    _descriptionController = TextEditingController(text: 'Form description');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addQuestion(QuestionType type) {
    setState(() {
      final id = _nextId++;
      _fields.add(FormFieldModel(id: id, type: type, options: ['Option 1']));
    });
  }

  void _deleteQuestion(int id) {
    setState(() {
      _fields.removeWhere((field) => field.id == id);
    });
  }

  void _updateQuestion(int id, String question) {
    setState(() {
      _fields.firstWhere((field) => field.id == id).question = question;
    });
  }

  void _updateOption(int fieldId, int optionIndex, String option) {
    setState(() {
      _fields
          .firstWhere((field) => field.id == fieldId)
          .options[optionIndex] = option;
    });
  }

  void _addOption(int fieldId) {
    setState(() {
      _fields
          .firstWhere((field) => field.id == fieldId)
          .options
          .add('Option ${_fields.firstWhere((field) => field.id == fieldId).options.length + 1}');
    });
  }

  void _removeOption(int fieldId, int optionIndex) {
    setState(() {
      _fields
          .firstWhere((field) => field.id == fieldId)
          .options
          .removeAt(optionIndex);
    });
  }

  Widget _buildQuestionWidget(FormFieldModel field) {
    switch (field.type) {
      case QuestionType.shortText:
        return ShortAnswerQuestion(
          field: field,
          onDelete: () => _deleteQuestion(field.id),
          onChanged: (value) => _updateQuestion(field.id, value),
        );
      case QuestionType.longText:
        return LongAnswerQuestion(
          field: field,
          onDelete: () => _deleteQuestion(field.id),
          onChanged: (value) => _updateQuestion(field.id, value),
        );
      case QuestionType.checkbox:
        return CheckboxQuestion(
          field: field,
          onDelete: () => _deleteQuestion(field.id),
          onChanged: (value) => _updateQuestion(field.id, value),
          onOptionChanged: (optionIndex, optionValue) =>
              _updateOption(field.id, optionIndex, optionValue),
          onAddOption: () => _addOption(field.id),
          onRemoveOption: (optionIndex) =>
              _removeOption(field.id, optionIndex),
        );
      case QuestionType.multipleChoice:
        return MultipleChoiceQuestion(
          field: field,
          onDelete: () => _deleteQuestion(field.id),
          onChanged: (value) => _updateQuestion(field.id, value),
          onOptionChanged: (optionIndex, optionValue) =>
              _updateOption(field.id, optionIndex, optionValue),
          onAddOption: () => _addOption(field.id),
          onRemoveOption: (optionIndex) =>
              _removeOption(field.id, optionIndex),
        );
      case QuestionType.dropdown:
        return DropdownQuestion(
          field: field,
          onDelete: () => _deleteQuestion(field.id),
          onChanged: (value) => _updateQuestion(field.id, value),
          onOptionChanged: (optionIndex, optionValue) =>
              _updateOption(field.id, optionIndex, optionValue),
          onAddOption: () => _addOption(field.id),
          onRemoveOption: (optionIndex) =>
              _removeOption(field.id, optionIndex),
        );
      case QuestionType.date:
        return DateQuestion(
          field: field,
          onDelete: () => _deleteQuestion(field.id),
          onChanged: (value) => _updateQuestion(field.id, value),
        );
      default:
        return Container();
    }
  }

  void _previewForm() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormPreviewPage(
          title: _titleController.text,
          description: _descriptionController.text,
          fields: _fields,
        ),
      ),
    );
  }

  void _saveForm() {
    final savedForm = SavedForm(
      title: _titleController.text,
      description: _descriptionController.text,
      fields: _fields,
    );
    Navigator.of(context).pop(savedForm);
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
        title: Row(
          children: [
            Expanded(
              child: TextField(
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
            ),
            Text('(${_fields.length} questions)'),
          ],
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.visibility, size: 18),
            label: const Text("Preview"),
            onPressed: _previewForm,
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
            onPressed: _saveForm,
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
                    FormTitleDescription(
                      titleController: _titleController,
                      descriptionController: _descriptionController,
                    ),
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _fields.length,
                      itemBuilder: (context, index) {
                        final field = _fields[index];
                        return Row(
                          key: ValueKey(field.id),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${index + 1}.'),
                            const SizedBox(width: 8),
                            Expanded(child: _buildQuestionWidget(field)),
                          ],
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final FormFieldModel item = _fields.removeAt(oldIndex);
                          _fields.insert(newIndex, item);
                        });
                      },
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