import 'package:flutter_appp/models/geometry.dart';

class Place {
  final Geometry geometry;
  final String name;
  final String vicinity;
  // api: https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4
  // models should be created from inside to out
  Place({required this.geometry, required this.name, required this.vicinity});

  factory Place.fromJSON(Map<String, dynamic> parsedJson) {
    return Place(geometry: Geometry.fromJSON(parsedJson['geometry']),
        name: parsedJson['formatted_address'],
        vicinity: parsedJson['vicinity']);
  }
}