// import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    // Check if location permission is granted
    var status = await Permission.location.status;
    if (status.isDenied) {
      // Request location permission
      status = await Permission.location.request();
      if (status.isPermanentlyDenied) {
        // Open app settings
        openAppSettings();
      }
    }

    if (status.isGranted) {
      // Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } else {
      throw Exception('Location permission is denied');
    }
  }
}
