import 'package:dio/dio.dart';
import 'package:flutter_appp/models/directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  String baseUrl = "https://maps.googleapis.com/maps/api/directions/json?";

  final Dio dio;

  DirectionsRepository({required this.dio});

  Future<Directions?> getDirections(
      {required LatLng origin, required LatLng dest}) async {
    final response = await dio.get(
      baseUrl, queryParameters: {
      'origin': '${origin.latitude}, ${origin.longitude}',
      'destination': '${dest.latitude}, ${dest.longitude}',
      'key': 'AIzaSyAhYQ6Lgwq2wxdBmpstnzRV7yosfjwRF6Q'
    }
    );
    if(response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
