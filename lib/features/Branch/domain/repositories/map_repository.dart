
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';

abstract class MapRepository {
  Future<List<PlaceSuggestion>> getAutocomplete(String query);
  Future<PlaceDetails> getPlaceDetails(String placeId);
}

