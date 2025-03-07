import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

final selectedLocationProvider = StateProvider<LatLng?>((ref) => null);
