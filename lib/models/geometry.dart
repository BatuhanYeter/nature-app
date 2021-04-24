import 'package:flutter_appp/models/location.dart';

class Geometry {
  final Location location;

  Geometry({required this.location});

  factory Geometry.fromJSON(Map<dynamic, dynamic> parsedJson) {
    return Geometry(location: Location.fromJSON(parsedJson['location']));
  }

}