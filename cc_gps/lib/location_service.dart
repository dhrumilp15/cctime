import 'package:location/location.dart';
import 'user_profile.dart';
import 'dart:async';

class LocationService {
  UserLocation _currentLocation;


  Location location = new Location();


  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Unlucky - couldn\'t get the location: ${e.toString()}');
    }

    return _currentLocation;
  }

  StreamController<UserLocation> _locationController = StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission()
        .then( (granted) {
      if (granted) {
        location.onLocationChanged().listen( (LocationData locationData) {
          if (locationData != null) {
            print(locationData.latitude);
            print(locationData.longitude);
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }
}