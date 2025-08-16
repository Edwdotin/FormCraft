import 'package:form_craft/models/form_field.dart';

class SavedForm {
  final String title;
  final String description;
  final List<FormFieldModel> fields;

  SavedForm({
    required this.title,
    required this.description,
    required this.fields,
  });
}
