import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:flutter/material.dart';

class MapSuggestionItem extends StatelessWidget {
  final PlaceSuggestion suggestion;
  final VoidCallback onTap;

  const MapSuggestionItem({
    super.key,
    required this.suggestion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.location_on, color: AppColors.primary),
      title: Row(

        children: [
          Expanded(
            child: Text(
              suggestion.mainText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _extractDistance(suggestion.secondaryText),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  String _extractDistance(String text) {
    final parts = text.split(',');
    if (parts.isNotEmpty) {
      String distPart = parts.last.trim();
      if (distPart.toLowerCase().contains('away')) {
        distPart = distPart.toLowerCase().replaceAll('away', '').trim();
      }
      return distPart;
    }
    return text;
  }
}