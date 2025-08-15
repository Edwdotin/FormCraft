import 'package:flutter/material.dart';

class FormAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(String) onTitleChanged;
  final VoidCallback onSubmissions;
  final VoidCallback onPreview;
  final VoidCallback onSave;

  const FormAppBar({
    super.key,
    required this.title,
    required this.onTitleChanged,
    required this.onSubmissions,
    required this.onPreview,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          // Back Button
          const VerticalDivider(width: 20, thickness: 1, color: Colors.grey),

          // Editable Title
          Expanded(
            child: TextField(
              controller: TextEditingController(text: title),
              onChanged: onTitleChanged,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Untitled Form",
              ),
            ),
          ),

          // Action Buttons
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: onSubmissions,
                icon: const Icon(Icons.bar_chart, size: 16),
                label: const Text("Submissions"),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: onPreview,
                icon: const Icon(Icons.remove_red_eye, size: 16),
                label: const Text("Preview"),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.save, size: 16),
                label: const Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
