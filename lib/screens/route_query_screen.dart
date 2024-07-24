import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteQueryScreen extends StatefulWidget {
  const RouteQueryScreen({Key? key}) : super(key: key);

  @override
  _RouteQueryScreenState createState() => _RouteQueryScreenState();
}

class _RouteQueryScreenState extends State<RouteQueryScreen> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  GoogleMapController? _mapController;
  Set<Polyline> _polylines = {};
  List<LatLng> _routePoints = [];

  Future<void> _fetchRoute(String start, String end) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=$start&destination=$end&key=YOUR_API_KEY'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final points = data['routes'][0]['overview_polyline']['points'];
      _routePoints = _decodePoly(points);

      setState(() {
        _polylines = {
          Polyline(
            polylineId: PolylineId('route'),
            points: _routePoints,
            color: Colors.blue,
            width: 5,
          ),
        };
      });
    } else {
      setState(() {
        _polylines = {};
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch route: ${response.statusCode}')),
      );
    }
  }

  List<LatLng> _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = <LatLng>[];
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      shift = 0;
      result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      double lat = (dlat + 0) / 1E5;
      double lng = (dlng + 0) / 1E5;
      lList.add(LatLng(lat, lng));
    } while (index < len);

    return lList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Query'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _startController,
                  decoration: const InputDecoration(
                    labelText: 'Enter start location',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _endController,
                  decoration: const InputDecoration(
                    labelText: 'Enter end location',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _fetchRoute(_startController.text, _endController.text);
                  },
                  child: const Text('Query Route'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // 默认位置为旧金山
                zoom: 12,
              ),
              polylines: _polylines,
              onMapCreated: (controller) {
                _mapController = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
