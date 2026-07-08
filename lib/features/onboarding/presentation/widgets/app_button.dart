import 'package:flutter/material.dart';

/// A reusable pill-shaped button.
///
/// Takes exactly 3 required params:
///   - [text]      — Button label
///   - [color]     — Background color (border is auto-applied for light colors)
///   - [onPressed] — Tap callback
class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Decide border & shadow based on how light the color is
    final isLight = color.computeLuminance() > 0.5;

    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          shadowColor: isLight ? const Color(0x2A000000) : const Color(0x3327AE60),
          backgroundColor: color,
          foregroundColor: const Color(0xFF1B1B1B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: isLight
                ? BorderSide(color: Colors.grey.shade300)
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
    );
  }
}
