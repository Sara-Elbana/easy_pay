import 'package:easy_pay_app/core/theme/app_colors.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/features/Branch/presentation/controllers/map_search_controller.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_cubit.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_state.dart';
import 'package:easy_pay_app/features/Branch/presentation/widgets/map_draggable_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({super.key});
  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {

  late MapSearchController _mapSearchController;

  @override
  void initState() {
    super.initState();
    _mapSearchController = MapSearchController(onStateChanged: () => setState(() {}));
  }

  @override
  void dispose() {
    _mapSearchController.dispose();
    super.dispose();
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
                _mapSearchController.updateMap(state.details);
              }
              if (state is PlaceDetailsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 14.0),
              markers: _mapSearchController.markers,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: _mapSearchController.onMapCreated,
            ),
          ),
          const MapDraggableSheet(),
        ],
      ),
    );
  }
}
