import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/core/errors/failures.dart';
import 'package:easy_pay_app/core/errors/exceptions.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto__place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';
import 'package:easy_pay_app/features/Branch/data/datasources/map_remote_data_source.dart';
import 'package:easy_pay_app/features/Branch/data/datasources/map_mock_data.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto_complete_request.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource remoteDataSource;
  MapRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<PlaceSuggestion>>> getAutocomplete(
      AutoCompleteRequest request) async {
    try {
      final suggestions = await remoteDataSource.getAutocomplete(request);
      return Right(suggestions);
    } on ServerException catch (e) {
      return Right(MapMockData.getMockSuggestions(request.query));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlaceDetails>> getPlaceDetails(
      AutoPlaceDetailsRequest request) async {
    try {
      final details = await remoteDataSource.getPlaceDetails(request);
      return Right(details);
    } on ServerException catch (e) {
      return Right(MapMockData.getMockPlaceDetails(request.placeId));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}