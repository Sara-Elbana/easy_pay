import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto__place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto_complete_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';

abstract class MapRepository {
  Future<Either<Failure, List<PlaceSuggestion>>> getAutocomplete(AutoCompleteRequest request);
  Future<Either<Failure, PlaceDetails>> getPlaceDetails(AutoPlaceDetailsRequest request);
}
