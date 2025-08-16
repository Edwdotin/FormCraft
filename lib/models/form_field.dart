import 'package:form_craft/utils/question_type.dart';

class FormFieldModel {
  final int id;
  final QuestionType type;
  String question;
  List<String> options;
  bool isRequired;

  FormFieldModel({
    required this.id,
    required this.type,
    this.question = 'Question',
    this.options = const ['Option 1'],
    this.isRequired = false,
  });
}
