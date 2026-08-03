import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/core/network/api_result.dart';
import 'package:easy_pay_app/core/network/api_service.dart';
import 'package:easy_pay_app/features/Branch/data/models/place_details_model.dart';
import 'package:easy_pay_app/features/Branch/data/models/place_suggestion_model.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_complete_request.dart';
import 'package:easy_pay_app/features/Branch/data/models/requests/auto_place_details_request.dart';

abstract class MapRemoteDataSource {
  Future<ApiResult<List<PlaceSuggestionModel>>> getAutocomplete(AutoCompleteRequest request);
  Future<ApiResult<PlaceDetailsModel>> getPlaceDetails(AutoPlaceDetailsRequest request);
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final ApiService apiService;
  List<Map<String, dynamic>> _cachedBranches = [];

  MapRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResult<List<PlaceSuggestionModel>>> getAutocomplete(AutoCompleteRequest request) async {
    try {
      final response = await apiService.get(
        ApiConstants.branchesEndpoint,
        queryParameters: request.query.isNotEmpty ? request.toJson() : null,
      );

      if (response.data != null && response.data is List) {
        final List rawData = response.data;
        _cachedBranches = List<Map<String, dynamic>>.from(rawData);

        final models = _cachedBranches.map((item) {
          return PlaceSuggestionModel(
            placeId: item['id'].toString(),
            description: item['address'] ?? '',
            mainText: item['name'] ?? '',
            secondaryText: item['distance_text'] ?? '',
          );
        }).toList();

        return ApiSuccess(data: models);
      }
      return const ApiFailure(error: 'Failed to load branches');
    } on DioException catch (e) {
      return ApiFailure(
        error: e.response?.data['message'] ??
            e.message ??
            ApiConstants.unknownError,
      );
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }

  @override
  Future<ApiResult<PlaceDetailsModel>> getPlaceDetails(AutoPlaceDetailsRequest request) async {
    try {
      if (_cachedBranches.isEmpty) {
        await getAutocomplete(const AutoCompleteRequest(query: ''));
      }

      final branch = _cachedBranches.firstWhere(
        (b) => b['id'].toString() == request.placeId,
        orElse: () => {},
      );

      if (branch.isNotEmpty) {
        final model = PlaceDetailsModel(
          name: branch['name'] ?? '',
          latitude: double.tryParse(branch['latitude'].toString()) ?? 30.0444,
          longitude: double.tryParse(branch['longitude'].toString()) ?? 31.2357,
          address: branch['address'] ?? '',
        );
        return ApiSuccess(data: model);
      }

      final fallbackModel = PlaceDetailsModel(
        name: 'Branch Details',
        latitude: 30.0444,
        longitude: 31.2357,
        address: 'Unknown Address',
      );
      return ApiSuccess(data: fallbackModel);
    } on DioException catch (e) {
      return ApiFailure(
        error: e.response?.data['message'] ??
            e.message ??
            ApiConstants.unknownError,
      );
    } catch (_) {
      return const ApiFailure(error: ApiConstants.unknownError);
    }
  }
}