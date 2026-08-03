import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_complete_request.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';

class GetAutocompleteUseCase {
  final MapRepository repository;

  GetAutocompleteUseCase(this.repository);

  Future<ApiResult<List<PlaceSuggestion>>> call(AutoCompleteRequest request) async {
    return await repository.getAutocomplete(request);
  }
}

class GetPlaceDetailsUseCase {
  final MapRepository repository;

  GetPlaceDetailsUseCase(this.repository);

  Future<ApiResult<PlaceDetails>> call(AutoPlaceDetailsRequest request) async {
    return await repository.getPlaceDetails(request);
  }
}