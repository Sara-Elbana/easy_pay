import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';

class PlaceDetailsModel extends PlaceDetails {
  PlaceDetailsModel({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.address,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    final location = json['geometry']['location'];
    return PlaceDetailsModel(
      name: json['name'] ,
      latitude: location['lat'] ,
      longitude: location['lng'],
      address: json['formatted_address'],
    );
  }
}