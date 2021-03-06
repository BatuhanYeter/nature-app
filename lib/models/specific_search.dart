import 'package:flutter_appp/models/geometry.dart';

class SpecificSearch {
  final Geometry geometry;
  final String address;
  final String placeId;
  final String name;
  final String? photoReference;
  // api: https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4
  // models should be created from inside to out
  SpecificSearch(
      {required this.geometry,
      required this.address,
      required this.placeId,
      required this.name, required this.photoReference});

  factory SpecificSearch.fromJSON(Map<String, dynamic> parsedJson) {
    return SpecificSearch(
      geometry: Geometry.fromJSON(parsedJson['geometry']),
      address: parsedJson['formatted_address'],
      placeId: parsedJson['place_id'],
      name: parsedJson['name'],
      photoReference: parsedJson['photos'] == null ? null : (parsedJson['photos'][0] == null ? null : parsedJson['photos'][0]['photo_reference'].toString())
    );
  }
}
