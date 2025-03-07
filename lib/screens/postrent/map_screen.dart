import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentfinderapp/providers/location_tracker_provider.dart';

class MapScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocation = ref.watch(selectedLocationProvider);
    return Scaffold(
      appBar: AppBar(title: Text('OpenStreetMap with Flutter')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(27.7172, 85.3240),
          onTap: (tapPosition, point) {
            ref.read(selectedLocationProvider.notifier).state = point;
          },
        ),

        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          if (selectedLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: selectedLocation,
                  child: Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          if (selectedLocation != null) {
            Get.back(result: selectedLocation);
          } else {
            Fluttertoast.showToast(
              msg: "No location selected.Please select a location first",
            );
          }
        },
        child: Text("+", style: TextStyle(fontSize: 28, color: Colors.white)),
      ),
    );
  }
}
