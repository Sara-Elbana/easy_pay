import 'package:flutter/material.dart';

class SwapButton extends StatelessWidget {
  final VoidCallback onTap;

  const SwapButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_downward,
              color: Color(0xFF3629B7),
              size: 24,
            ),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_upward,
              color: Color(0xFFFF4267),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
