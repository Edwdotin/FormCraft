import 'package:flutter/material.dart';
import 'package:form_craft/models/form_field.dart';
import 'package:form_craft/models/saved_form.dart';
import 'package:form_craft/utils/question_type.dart';

class AttendFormPage extends StatefulWidget {
  final SavedForm form;

  const AttendFormPage({super.key, required this.form});

  @override
  State<AttendFormPage> createState() => _AttendFormPageState();
}

class _AttendFormPageState extends State<AttendFormPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<int, dynamic> _answers = {};

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop(true);
    }
  }

  Widget _buildAnswerWidget(FormFieldModel field) {
    switch (field.type) {
      case QuestionType.shortText:
        return TextFormField(
          decoration: const InputDecoration(
            hintText: 'Your answer',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (field.isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
          onSaved: (value) => _answers[field.id] = value,
        );
      case QuestionType.longText:
        return TextFormField(
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Your answer',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (field.isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
          onSaved: (value) => _answers[field.id] = value,
        );
      case QuestionType.checkbox:
        return _CheckboxAnswer(
          field: field,
          onSaved: (value) => _answers[field.id] = value,
        );
      case QuestionType.multipleChoice:
        return _MultipleChoiceAnswer(
          field: field,
          onSaved: (value) => _answers[field.id] = value,
        );
      case QuestionType.dropdown:
        return DropdownButtonFormField<String>(
          items: field.options.map((option) {
            return DropdownMenuItem(value: option, child: Text(option));
          }).toList(),
          onChanged: (value) {},
          onSaved: (value) => _answers[field.id] = value,
          validator: (value) {
            if (field.isRequired && value == null) {
              return 'Please select an option';
            }
            return null;
          },
          decoration: const InputDecoration(border: OutlineInputBorder()),
        );
      case QuestionType.date:
        return _DateAnswer(
          field: field,
          onSaved: (value) => _answers[field.id] = value,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.form.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.form.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              ...widget.form.fields.map((field) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.titleLarge,
                          children: [
                            TextSpan(text: field.question),
                            if (field.isRequired)
                              const TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildAnswerWidget(field),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckboxAnswer extends StatefulWidget {
  final FormFieldModel field;
  final ValueChanged<List<String>> onSaved;

  const _CheckboxAnswer({required this.field, required this.onSaved});

  @override
  State<_CheckboxAnswer> createState() => _CheckboxAnswerState();
}

class _CheckboxAnswerState extends State<_CheckboxAnswer> {
  final List<String> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return FormField<List<String>>(
      onSaved: (value) => widget.onSaved(_selectedOptions),
      validator: (value) {
        if (widget.field.isRequired && _selectedOptions.isEmpty) {
          return 'Please select at least one option';
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.field.options.map((option) {
              return CheckboxListTile(
                title: Text(option),
                value: _selectedOptions.contains(option),
                onChanged: (isSelected) {
                  setState(() {
                    if (isSelected!) {
                      _selectedOptions.add(option);
                    } else {
                      _selectedOptions.remove(option);
                    }
                    state.didChange(_selectedOptions);
                  });
                },
              );
            }).toList(),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                ),
              )
          ],
        );
      },
    );
  }
}

class _MultipleChoiceAnswer extends StatefulWidget {
  final FormFieldModel field;
  final ValueChanged<String?> onSaved;

  const _MultipleChoiceAnswer({required this.field, required this.onSaved});

  @override
  State<_MultipleChoiceAnswer> createState() => _MultipleChoiceAnswerState();
}

class _MultipleChoiceAnswerState extends State<_MultipleChoiceAnswer> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      onSaved: (value) => widget.onSaved(_selectedOption),
      validator: (value) {
        if (widget.field.isRequired && _selectedOption == null) {
          return 'Please select an option';
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.field.options.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                    state.didChange(value);
                  });
                },
              );
            }).toList(),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                ),
              )
          ],
        );
      },
    );
  }
}

class _DateAnswer extends StatefulWidget {
  final FormFieldModel field;
  final ValueChanged<DateTime?> onSaved;

  const _DateAnswer({required this.field, required this.onSaved});

  @override
  State<_DateAnswer> createState() => _DateAnswerState();
}

class _DateAnswerState extends State<_DateAnswer> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      onSaved: (value) => widget.onSaved(_selectedDate),
      validator: (value) {
        if (widget.field.isRequired && _selectedDate == null) {
          return 'Please select a date';
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? 'Select Date'
                  : '${_selectedDate!.toLocal()}'.split(' ')[0]),
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                    state.didChange(pickedDate);
                  });
                }
              },
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                ),
              )
          ],
        );
      },
    );
  }
}
