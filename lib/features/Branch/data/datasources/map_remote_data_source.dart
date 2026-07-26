import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:easy_pay_app/core/constants/api_constants.dart';
import 'package:easy_pay_app/features/Branch/data/models/place_model.dart';

abstract class MapRemoteDataSource {
  Future<List<PlaceSuggestionModel>> getAutocomplete(String query);
  Future<PlaceDetailsModel> getPlaceDetails(String placeId);
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final Dio dio;
  List<Map<String, dynamic>> _cachedBranches = [];

  MapRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PlaceSuggestionModel>> getAutocomplete(String query) async {
    try {
      final response = await dio.get(
        ApiConstants.branchesEndpoint,
        queryParameters: query.isNotEmpty ? {'query': query} : null,
      );

      if (response.statusCode == 200 && response.data != null) {
        final List rawData = response.data;
        _cachedBranches = List<Map<String, dynamic>>.from(rawData);

        return _cachedBranches.map((item) {
          return PlaceSuggestionModel(
            placeId: item['id'].toString(),
            description: item['address'] ?? '',
            mainText: item['name'] ?? '',
            secondaryText: item['distance_text'] ?? '',
          );
        }).toList();
      }
      throw Exception('Failed to load branches');
    } catch (e) {
      developer.log("⚠️ Error loading branches: $e");
      return [];
    }
  }

  @override
  Future<PlaceDetailsModel> getPlaceDetails(String placeId) async {
    try {
      // If cache is empty (e.g. direct load), fetch all branches first
      if (_cachedBranches.isEmpty) {
        await getAutocomplete('');
      }

      final branch = _cachedBranches.firstWhere(
        (b) => b['id'].toString() == placeId,
        orElse: () => throw Exception('Branch not found in cache'),
      );

      return PlaceDetailsModel(
        name: branch['name'] ?? '',
        latitude: double.parse(branch['latitude'].toString()),
        longitude: double.parse(branch['longitude'].toString()),
        address: branch['address'] ?? '',
      );
    } catch (e) {
      developer.log("⚠️ Error getting place details: $e");
      // Fallback
      return PlaceDetailsModel(
        name: 'Branch Details',
        latitude: 30.0444,
        longitude: 31.2357,
        address: 'Unknown Address',
      );
    }
  }
}