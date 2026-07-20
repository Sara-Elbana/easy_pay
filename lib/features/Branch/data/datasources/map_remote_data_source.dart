import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/errors/exceptions.dart';
import 'package:easy_pay_app/core/network/api_config.dart';
import 'package:easy_pay_app/features/Branch/data/datasources/map_mock_data.dart';
import 'package:easy_pay_app/features/Branch/data/models/place_details_model.dart';
import 'package:easy_pay_app/features/Branch/data/models/place_suggestion_model.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto__place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto_complete_request.dart';

abstract class MapRemoteDataSource {
  Future<List<PlaceSuggestionModel>> getAutocomplete(
      AutoCompleteRequest request);
  Future<PlaceDetailsModel> getPlaceDetails(AutoPlaceDetailsRequest request);
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final Dio dio;

  MapRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PlaceSuggestionModel>> getAutocomplete(
      AutoCompleteRequest request) async {
    if (request.query.startsWith('mock_')) {
      return MapMockData.getMockSuggestions(request.query);
    }
    try {
      final response = await dio.get(
        '${ApiConstants.googleMapsBaseUrl}${ApiConstants.autocompleteEndpoint}',
        queryParameters: {
          'input': request.query,
          'key': ApiConfig.googleMapsApiKey,
          'components': 'country:eg',
        },
      );
      if (response.data['status'] == 'OK') {
        final predictions = (response.data['predictions'] as List?) ?? [];
        return predictions
            .map((json) => PlaceSuggestionModel.fromJson(json))
            .toList();
      } else if (response.data['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw ServerException(
          message: response.data['error_message'] ?? 'API Error');
    } catch (e) {
      return MapMockData.getMockSuggestions(request.query);
    }
  }

  @override
  Future<PlaceDetailsModel> getPlaceDetails(
      AutoPlaceDetailsRequest request) async {
    if (request.placeId.startsWith('mock_')) {
      return MapMockData.getMockPlaceDetails(request.placeId);
    }
    try {
      final response = await dio.get(
        '${ApiConstants.googleMapsBaseUrl}${ApiConstants.placeDetailsEndpoint}',
        queryParameters: {
          'place_id': request.placeId,
          'fields': 'name,geometry,formatted_address',
          'key': ApiConfig.googleMapsApiKey,
        },
      );

      if (response.data['status'] == 'OK') {
        return PlaceDetailsModel.fromJson(response.data['result']);
      } else {
        throw ServerException(message: response.data['error_message'] ?? 'Failed');
      }
    } catch (e) {
      return MapMockData.getMockPlaceDetails(request.placeId);
    }
  }
}
