import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/features/Branch/domain/entities/place_entity.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_cubit.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_state.dart';
import 'package:easy_pay_app/features/Branch/presentation/widgets/map_draggable_sheet.dart';
import 'package:easy_pay_app/features/Branch/presentation/widgets/map_theme_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({super.key});
  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 14.0,
  );

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    // ignore: deprecated_member_use
    _mapController?.setMapStyle(MapThemeConfigs.silverMapStyle);
  }

  void _updateMap(PlaceDetails details) {
    final position = LatLng(details.latitude, details.longitude);
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(details.name),
          position: position,
          infoWindow: InfoWindow(title: details.name, snippet: details.address),
          icon: BitmapDescriptor.defaultMarkerWithHue(250.0),
        ),
      );
    });

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: "Branch"),
      body: Stack(
        children: [
          BlocListener<MapCubit, MapState>(
            listener: (context, state) {
              if (state is PlaceDetailsSuccess) {
                _updateMap(state.details);
              }
              if (state is PlaceDetailsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              markers: _markers,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              onMapCreated: _onMapCreated,
            ),
          ),
          const MapDraggableSheet(),
        ],
      ),
    );
  }
}
