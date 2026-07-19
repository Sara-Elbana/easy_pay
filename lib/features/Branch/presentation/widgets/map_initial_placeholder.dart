import 'package:flutter/material.dart';

class MapInitialPlaceholder extends StatelessWidget {
  final ScrollController scrollController;

  const MapInitialPlaceholder({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(20),
      children: const [
        SizedBox(height: 40),
        Center(
          child: Text(
            'Start searching for a bank, branch or place',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}