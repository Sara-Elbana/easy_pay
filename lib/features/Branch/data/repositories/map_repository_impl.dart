import 'dart:async';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/features/Branch/data/datasources/map_mock_data.dart';
import 'package:easy_pay_app/features/Branch/data/datasources/map_remote_data_source.dart';
import 'package:easy_pay_app/features/Branch/data/models/place_details_model.dart';
import 'package:easy_pay_app/features/Branch/data/models/place_suggestion_model.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_complete_request.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_suggestion.dart';
import 'package:easy_pay_app/features/Branch/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource remoteDataSource;

  MapRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<List<PlaceSuggestion>>> getAutocomplete(
      AutoCompleteRequest request) async {
    final result = await remoteDataSource.getAutocomplete(request);
    if (result is ApiSuccess<List<PlaceSuggestionModel>>) {
      return ApiSuccess(data: result.data, message: result.message);
    }
    final mockData = MapMockData.getMockSuggestions(request.query);
    return ApiSuccess(data: mockData);
  }

  @override
  Future<ApiResult<PlaceDetails>> getPlaceDetails(
      AutoPlaceDetailsRequest request) async {
    final result = await remoteDataSource.getPlaceDetails(request);
    if (result is ApiSuccess<PlaceDetailsModel>) {
      return ApiSuccess(data: result.data, message: result.message);
    }
    final mockData = MapMockData.getMockPlaceDetails(request.placeId);
    return ApiSuccess(data: mockData);
  }
}