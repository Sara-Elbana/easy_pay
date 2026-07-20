import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';

class PlaceSuggestionModel extends PlaceSuggestion {
  PlaceSuggestionModel({
    required super.placeId,
    required super.description,
    required super.mainText,
    required super.secondaryText,
  });

  factory PlaceSuggestionModel.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestionModel(
      placeId: json['place_id'],
      description: json['description'],
      mainText: json['structured_formatting']?['main_text'],
      secondaryText: json['structured_formatting']?['secondary_text'],
    );
  }
}


