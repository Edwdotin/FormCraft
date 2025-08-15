import 'package:flutter/material.dart';
import 'package:form_craft/utils/question_type.dart';

class QuestionTypesSidebar extends StatelessWidget {
  final void Function(QuestionType) onAddQuestion;

  const QuestionTypesSidebar({super.key, required this.onAddQuestion});

  @override
  Widget build(BuildContext context) {
    final questionTypes = [
      {
        'type': QuestionType.shortText,
        'label': 'Short Text',
        'icon': Icons.text_fields,
      },
      {
        'type': QuestionType.longText,
        'label': 'Long Text',
        'icon': Icons.notes,
      },
      {
        'type': QuestionType.multipleChoice,
        'label': 'Multiple Choice',
        'icon': Icons.check_box,
      },
      {
        'type': QuestionType.checkbox,
        'label': 'Checkboxes',
        'icon': Icons.check_box_outline_blank,
      },
      {
        'type': QuestionType.dropdown,
        'label': 'Dropdown',
        'icon': Icons.arrow_drop_down_circle,
      },
      {
        'type': QuestionType.date,
        'label': 'Date',
        'icon': Icons.calendar_today,
      },
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wrap height tightly
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Add Questions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Colors.grey),
          // Buttons
          Column(
            mainAxisSize: MainAxisSize.min, // Wrap height tightly
            children: questionTypes.map((q) {
              return _QuestionButton(
                label: q['label'] as String,
                icon: q['icon'] as IconData,
                onTap: () => onAddQuestion(q['type'] as QuestionType),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _QuestionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _QuestionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_QuestionButton> createState() => _QuestionButtonState();
}

class _QuestionButtonState extends State<_QuestionButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final hoverColor = Theme.of(context).primaryColor;
    final onHoverColor = Theme.of(context).colorScheme.onPrimary;
    final defaultColor = Theme.of(context).colorScheme.onSurface;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: _hovering ? hoverColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min, // wrap row tightly
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: _hovering ? onHoverColor : defaultColor,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  color: _hovering ? onHoverColor : defaultColor,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.add,
                size: 16,
                color: _hovering ? onHoverColor : defaultColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
