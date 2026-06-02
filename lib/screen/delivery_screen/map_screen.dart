import 'package:coffe_app/screen/delivery_screen/contact_section.dart';
import 'package:coffe_app/screen/delivery_screen/delivered_order_section.dart';
import 'package:coffe_app/screen/delivery_screen/map_section.dart';
import 'package:coffe_app/screen/delivery_screen/progress_bar_section.dart';
import 'package:coffe_app/screen/delivery_screen/time_section.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MapSection(),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsetsGeometry.only(right: 30, left: 30),
              child: Column(
                children: [
                  Divider(
                    height: 30,
                    thickness: 5,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                    indent: 180,
                    endIndent: 180,
                  ),
                  TimeSection(),
                  SizedBox(height: 15),
                  ProgressBarSection(),
                  SizedBox(height: 15),
                  DeliveredOrderSection(),
                  SizedBox(height: 10),
                  ContactSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
