import 'package:flutter/material.dart';
import 'package:form_craft/themes/theme.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final double? width;
  final double? height;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final button = TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        overlayColor: WidgetStatePropertyAll(
          Colors.white.withValues(alpha: 0.1),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        ),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return primaryGreen.withValues(alpha: 0.8);
          }
          return primaryGreen;
        }),
      ),
    );

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }

    return button;
  }
}
