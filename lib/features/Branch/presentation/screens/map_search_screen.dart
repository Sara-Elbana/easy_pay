import 'package:easy_pay_app/features/Branch/domain/entities/place_entity.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_cubit.dart';
import 'package:easy_pay_app/features/Branch/presentation/cubit/map_state.dart';
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
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> _markers = {};

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 14.0,
  );

  static const String _silverMapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
''';

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController?.setMapStyle(_silverMapStyle);
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            markers: _markers,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: Material(
              elevation: 2,
              shape: const CircleBorder(),
              color: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.black87, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.15,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {});
                          context.read<MapCubit>().searchPlaces(val);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search here...',
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.black54),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear,
                                      color: Colors.black54),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {});
                                    context.read<MapCubit>().searchPlaces('');
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: const Color(0xFFF6F6F6),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: BlocConsumer<MapCubit, MapState>(
                        listener: (context, state) {
                          if (state is PlaceDetailsSuccess) {
                            _updateMap(state.details);
                          }
                          if (state is AutocompleteError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AutocompleteLoading ||
                              state is PlaceDetailsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF635BFF)),
                              ),
                            );
                          }

                          if (state is AutocompleteSuccess) {
                            return ListView.separated(
                              controller: scrollController,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: state.suggestions.length,
                              separatorBuilder: (_, __) => const Divider(
                                  height: 1, color: Color(0xFFEEEEEE)),
                              itemBuilder: (context, index) {
                                final item = state.suggestions[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const CircleAvatar(
                                    backgroundColor: Color(0xFFECEBFC),
                                    child: Icon(Icons.location_on,
                                        color: Color(0xFF635BFF)),
                                  ),
                                  title: Text(
                                    item.mainText,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.secondaryText,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    _searchController.text = item.mainText;
                                    context
                                        .read<MapCubit>()
                                        .selectPlace(item.placeId);
                                  },
                                );
                              },
                            );
                          }

                          return ListView(
                            controller: scrollController,
                            padding: const EdgeInsets.all(20),
                            children: const [
                              SizedBox(height: 40),
                              Center(
                                child: Text(
                                  'Start searching for a bank, branch or place',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
