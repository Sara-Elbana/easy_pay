class AutoPlaceDetailsRequest {
  final String placeId;

  const AutoPlaceDetailsRequest({
    required this.placeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
    };
  }
}
