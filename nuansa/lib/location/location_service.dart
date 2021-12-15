import 'dart:async';

import 'package:location/location.dart';
import 'package:nuansa/location/user_location.dart';
// import 'package:realtime_update_user_location/user_location.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> _locationStreamController = StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    try {
      location.requestPermission().then((permissionStatus) {
        if (permissionStatus == PermissionStatus.granted) {
          location.onLocationChanged.listen((locationData) {
            print(locationData.latitude);
            _locationStreamController.add(UserLocation(latitude: locationData.latitude ?? 0, longitude: locationData.longitude ?? 0));
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void dispose() => _locationStreamController.close();
}