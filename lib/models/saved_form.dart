import 'package:form_craft/models/form_field.dart';

class SavedForm {
  final String title;
  final String description;
  final List<FormFieldModel> fields;
  bool isSubmitted;
  Map<int, dynamic> answers;

  SavedForm({
    required this.title,
    required this.description,
    required this.fields,
    this.isSubmitted = false,
    this.answers = const {},
  });
}
