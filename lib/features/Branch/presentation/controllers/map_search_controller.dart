import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_details.dart';
import 'package:easy_pay_app/features/Branch/presentation/widgets/map_theme_configs.dart';

class MapSearchController {
  GoogleMapController? mapController;
  final Set<Marker> markers = {};
  final Function() onStateChanged;

  MapSearchController({required this.onStateChanged});

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController?.setMapStyle(MapThemeConfigs.silverMapStyle);
  }

  void updateMap(PlaceDetails details) {
    final position = LatLng(details.latitude, details.longitude);
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(details.name),
        position: position,
        infoWindow: InfoWindow(title: details.name, snippet: details.address),
        icon: BitmapDescriptor.defaultMarkerWithHue(250.0),
      ),
    );

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 16.0),
      ),
    );
    onStateChanged();
  }

  void dispose() {
    mapController?.dispose();
  }
}