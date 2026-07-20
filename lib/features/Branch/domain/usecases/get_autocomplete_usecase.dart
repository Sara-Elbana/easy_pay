import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto__place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto_complete_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';

class GetAutocompleteUseCase {
  final MapRepository repository;

  GetAutocompleteUseCase(this.repository);

  Future<Either<Failure, List<PlaceSuggestion>>> call(
      {required AutoCompleteRequest request}) {
    return repository.getAutocomplete(request);
  }
}

class GetPlaceDetailsUseCase {
  final MapRepository repository;

  GetPlaceDetailsUseCase(this.repository);

  Future<Either<Failure, PlaceDetails>> call(AutoPlaceDetailsRequest request) {
    return repository.getPlaceDetails(request);
  }
}

