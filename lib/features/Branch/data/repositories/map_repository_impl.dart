import 'dart:async';
import 'package:easy_pay_app/features/Branch/data/datasources/map_mock_data.dart';
import 'package:easy_pay_app/features/Branch/data/datasources/map_remote_data_source.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto__place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto_complete_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource remoteDataSource;

  MapRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PlaceSuggestion>> getAutocomplete(
      AutoCompleteRequest request) async {
    try {
      return await remoteDataSource.getAutocomplete(request.query);
    } catch (_) {
      return MapMockData.getMockSuggestions(request.query);
    }
  }

  @override
  Future<PlaceDetails> getPlaceDetails(
      AutoPlaceDetailsRequest request) async {
    try {
      return await remoteDataSource.getPlaceDetails(request.placeId);
    } catch (_) {
      return MapMockData.getMockPlaceDetails(request.placeId);
    }
  }
}