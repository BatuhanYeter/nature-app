import 'package:geolocator/geolocator.dart';

class GeoLocatorService {

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Stream<Position> getCurrentLocationStream(){
    return Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high, distanceFilter: 10);
  }

}