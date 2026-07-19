import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_entity.dart';

abstract class MapRepository {
  Future<Either<Failure, List<PlaceSuggestion>>> getAutocomplete(String query);
  Future<Either<Failure, PlaceDetails>> getPlaceDetails(String placeId);
}

class Failure {
  final String message;
  Failure(this.message);
}

