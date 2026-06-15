import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationSearchModal extends StatefulWidget {
  final Function(String, LatLng) onLocationSelected;

  const LocationSearchModal({super.key, required this.onLocationSelected});

  @override
  State<LocationSearchModal> createState() => _LocationSearchModalState();
}

class _LocationSearchModalState extends State<LocationSearchModal> {
  final TextEditingController _controller = TextEditingController();

  final String _mapboxToken =
      "pk.eyJ1IjoibWFrZGV2IiwiYSI6ImNtcTl0enY1czAwejkycXM5MTVheG1pZmMifQ.arx7M1XronOzoK2ZYyWV0A";

  List<dynamic> _predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _fetchPredictions(query);
      } else {
        setState(() {
          _predictions = [];
        });
      }
    });
  }

  Future<void> _fetchPredictions(String input) async {
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${Uri.encodeComponent(input)}.json'
        '?access_token=$_mapboxToken'
        '&autocomplete=true'
        '&limit=5';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _predictions = data['features'];
        });
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // handle bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // title + search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Text("Search Location", style: Theme.of(context).textTheme.titleLarge),

                const SizedBox(height: 12),

                TextField(
                  controller: _controller,
                  onChanged: (v) {
                    setState(() {});
                    _onSearchChanged(v);
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search place...",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              _onSearchChanged('');
                              setState(() {});
                            },
                          )
                        : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // results
          Expanded(
            child: _predictions.isEmpty && _controller.text.isEmpty
                ? const Center(child: Text("Start typing to search locations"))
                : ListView.builder(
                    itemCount: _predictions.length,
                    itemBuilder: (context, index) {
                      final p = _predictions[index];
                      final String mainText = p['text'] ?? "";
                      final String fullAddress = p['place_name'] ?? "";

                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(mainText),
                        subtitle: Text(fullAddress),
                        onTap: () {
                          final List<dynamic> center = p['center'];
                          final latLng = LatLng(center[1], center[0]);

                          widget.onLocationSelected(mainText, latLng);

                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// "You must enable Billing on the Google Cloud Project at https://console.cloud.google.com/project/_/billing/enable Learn more at https://developers.google.com/maps/gmp-get-started"
