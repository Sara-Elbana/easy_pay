import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_complete_request.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';

abstract class MapRepository {
  Future<ApiResult<List<PlaceSuggestion>>> getAutocomplete(AutoCompleteRequest request);
  Future<ApiResult<PlaceDetails>> getPlaceDetails(AutoPlaceDetailsRequest request);
}
 