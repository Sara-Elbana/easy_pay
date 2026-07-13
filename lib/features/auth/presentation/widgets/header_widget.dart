import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const HeaderWidget(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.paddingOf(context).top;
    return Container(
      padding: EdgeInsets.only(
        top: statusBarHeight + 10,
        bottom: 20,
        left: 10,
        right: 20,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
            onPressed: onPressed,
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
