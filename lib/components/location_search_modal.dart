import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class LocationSearchModal extends StatefulWidget {
  final Function(String, LatLng) onLocationSelected;

  const LocationSearchModal({super.key, required this.onLocationSelected});

  @override
  State<LocationSearchModal> createState() => _LocationSearchModalState();
}

class _LocationSearchModalState extends State<LocationSearchModal> {
  final TextEditingController _controller = TextEditingController();

  final String _apiKey = "AIzaSyC5HVloQvTIlkXawfGsM5xY4I7psY0ug9I";

  List<dynamic> _predictions = [];
  Timer? _debounce;

  final _uuid = const Uuid();
  String? _sessionToken;

  @override
  void initState() {
    super.initState();
    _sessionToken = _uuid.v4();
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
        'https://maps.googleapis.com/maps/api/place/autocomplete/json'
        '?input=$input'
        '&key=$_apiKey'
        '&sessiontoken=$_sessionToken'
        '&components=country:tz';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          setState(() {
            _predictions = data['predictions'];
          });
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<LatLng> _getLatLngFromPlaceId(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json"
        "?place_id=$placeId"
        "&key=$_apiKey";

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    final location = data['result']['geometry']['location'];

    return LatLng(location['lat'], location['lng']);
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

                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(p['structured_formatting']['main_text'] ?? ""),
                        subtitle: Text(
                          p['structured_formatting']['secondary_text'] ?? "",
                        ),
                        onTap: () async {
                          final placeId = p['place_id'];
                          final mainText = p['structured_formatting']['main_text'] ?? "";

                          final latLng = await _getLatLngFromPlaceId(placeId);

                          widget.onLocationSelected(mainText, latLng);

                          // refresh session token (important)
                          _sessionToken = _uuid.v4();

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
