import 'package:easy_pay_app/features/Branch/domain/entities/place_entity.dart';

class PlaceSuggestionModel extends PlaceSuggestion {
  PlaceSuggestionModel({
    required super.placeId,
    required super.description,
    required super.mainText,
    required super.secondaryText,
  });

  factory PlaceSuggestionModel.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestionModel(
      placeId: json['place_id'] ?? '',
      description: json['description'] ?? '',
      mainText: json['structured_formatting']?['main_text'] ?? '',
      secondaryText: json['structured_formatting']?['secondary_text'] ?? '',
    );
  }
}

class PlaceDetailsModel extends PlaceDetails {
  PlaceDetailsModel({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.address,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    final location = json['geometry']['location'];
    return PlaceDetailsModel(
      name: json['name'] ?? '',
      latitude: location['lat'] as double,
      longitude: location['lng'] as double,
      address: json['formatted_address'] ?? '',
    );
  }
}
