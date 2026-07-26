import 'package:easy_pay_app/features/Branch/data/datasources/map_remote_data_source.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource remoteDataSource;

  MapRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PlaceSuggestion>> getAutocomplete(String query) async {
    return await remoteDataSource.getAutocomplete(query);
  }

  @override
  Future<PlaceDetails> getPlaceDetails(String placeId) async {
    return await remoteDataSource.getPlaceDetails(placeId);
  }
}
