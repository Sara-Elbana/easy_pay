
import 'package:easy_pay_app/features/Branch/data/models/place_details_model.dart';
import 'package:easy_pay_app/features/Branch/data/models/place_suggestion_model.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto__place_details_request.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/auto_complete_request.dart';

class MapMockData {
  static List<PlaceSuggestionModel> getMockSuggestions(String query) {
    final List<Map<String, dynamic>> allMocks = [
      {
        'place_id': 'mock_cib_zamalek',
        'description': 'CIB Bank - Zamalek Branch, Cairo, Egypt',
        'structured_formatting': {
          'main_text': 'CIB Bank Zamalek',
          'secondary_text': 'Zamalek, 50m away'
        }
      },
      {
        'place_id': 'mock_qnb_mohandessin',
        'description': 'QNB Alahli - Mohandessin Branch, Giza, Egypt',
        'structured_formatting': {
          'main_text': 'QNB Mohandessin',
          'secondary_text': 'Mohandessin, 1.2km away'
        }
      },
      {
        'place_id': 'mock_nbe_downtown',
        'description': 'National Bank of Egypt - Downtown Branch, Cairo, Egypt',
        'structured_formatting': {
          'main_text': 'NBE Downtown Branch',
          'secondary_text': 'Tahrir Square, 5.3km away'
        }
      },
      {
        'place_id': 'mock_bm_nasrcity',
        'description': 'Banque Misr - Nasr City Branch, Cairo, Egypt',
        'structured_formatting': {
          'main_text': 'Banque Misr Nasr City',
          'secondary_text': 'Abbas El Akkad, 70m away'
        }
      },
      {
        'place_id': 'mock_hsbc_maadi',
        'description': 'HSBC Bank - Maadi Branch, Cairo, Egypt',
        'structured_formatting': {
          'main_text': 'HSBC Maadi Branch',
          'secondary_text': 'Road 9, Maadi, 30m away'
        }
      }
    ];

    final filtered = allMocks.where((element) {
      final mainText = element['structured_formatting']['main_text'].toString().toLowerCase();
      final description = element['description'].toString().toLowerCase();
      return mainText.contains(query.toLowerCase()) || description.contains(query.toLowerCase());
    }).toList();

    final listToParse = filtered.isEmpty && query.isEmpty ? allMocks : filtered;
    return listToParse.map((json) => PlaceSuggestionModel.fromJson(json)).toList();
  }

  static PlaceDetailsModel getMockPlaceDetails(String placeId) {
    switch (placeId) {
      case 'mock_cib_zamalek':
        return PlaceDetailsModel(
          name: 'CIB Bank Zamalek',
          latitude: 30.0596,
          longitude: 31.2217,
          address: 'Zamalek, Cairo, Egypt',
        );
      case 'mock_qnb_mohandessin':
        return PlaceDetailsModel(
          name: 'QNB Mohandessin',
          latitude: 30.0511,
          longitude: 31.2001,
          address: 'Mohandessin, Giza, Egypt',
        );
      case 'mock_nbe_downtown':
        return PlaceDetailsModel(
          name: 'NBE Downtown Branch',
          latitude: 30.0444,
          longitude: 31.2357,
          address: 'Downtown, Cairo, Egypt',
        );
      case 'mock_bm_nasrcity':
        return PlaceDetailsModel(
          name: 'Banque Misr Nasr City',
          latitude: 30.0566,
          longitude: 31.3301,
          address: 'Nasr City, Cairo, Egypt',
        );
      case 'mock_hsbc_maadi':
        return PlaceDetailsModel(
          name: 'HSBC Maadi Branch',
          latitude: 29.9602,
          longitude: 31.2569,
          address: 'Maadi, Cairo, Egypt',
        );
      default:
        return PlaceDetailsModel(
          name: 'CIB Bank Zamalek',
          latitude: 30.0596,
          longitude: 31.2217,
          address: 'Zamalek, Cairo, Egypt',
        );
    }
  }
}