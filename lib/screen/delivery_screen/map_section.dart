import 'package:coffe_app/screen/delivery_screen/map_app_bar.dart';
import 'package:flutter/material.dart';

import '../../assets_lib/images.dart';

class MapSection extends StatelessWidget {
  const MapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.55,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(Images.mapImage, fit: BoxFit.cover),
          ),
          Positioned(top: 50, left: 30, right: 30, child: MapAppBar()),
        ],
      ),
    );
  }
}
