import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<String?> getCurrentCoordinates() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!serviceEnabled || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position pos = await Geolocator.getCurrentPosition();
    return "${pos.latitude}, ${pos.longitude}";
  }
}
