class PlaceSuggestion {
  final String placeId;
  final String description;
  final String mainText;
  final String secondaryText;

  PlaceSuggestion({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
  });
}

class PlaceDetails {
  final String name;
  final double latitude;
  final double longitude;
  final String address;

  PlaceDetails({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}
