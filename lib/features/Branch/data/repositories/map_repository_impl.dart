import 'package:dartz/dartz.dart';
import 'package:easy_pay_app/features/Branch/data/datasources/map_remote_data_source.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_entity.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource remoteDataSource;

  MapRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<PlaceSuggestion>>> getAutocomplete(
      String query) async {
    try {
      final suggestions = await remoteDataSource.getAutocomplete(query);
      return Right(suggestions);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlaceDetails>> getPlaceDetails(String placeId) async {
    try {
      final details = await remoteDataSource.getPlaceDetails(placeId);
      return Right(details);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
