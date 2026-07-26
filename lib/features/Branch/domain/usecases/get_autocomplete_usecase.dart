import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';

class GetAutocompleteUseCase {
  final MapRepository repository;

  GetAutocompleteUseCase(this.repository);

  Future<List<PlaceSuggestion>> call(String query) {
    return repository.getAutocomplete(query);
  }
}

class GetPlaceDetailsUseCase {
  final MapRepository repository;

  GetPlaceDetailsUseCase(this.repository);

  Future<PlaceDetails> call(String placeId) {
    return repository.getPlaceDetails(placeId);
  }
}

