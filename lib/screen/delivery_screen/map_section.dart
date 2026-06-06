import 'dart:async';

import 'package:coffe_app/screen/delivery_screen/map_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(-6.8227, 39.291),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.55,
      child: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: _kGoogle,
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              // Keep the marker from the previous version for the delivery feel
              markers: {
                const Marker(
                  markerId: MarkerId('delivery_location'),
                  position: LatLng(-6.8227, 39.291),
                  infoWindow: InfoWindow(
                    title: 'Coffee Delivery',
                    snippet: 'Your order is on the way!',
                  ),
                ),
              },
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapToolbarEnabled: true,
            ),
          ),
          Positioned(top: 50, left: 30, right: 30, child: MapAppBar()),
        ],
      ),
    );
  }
}
