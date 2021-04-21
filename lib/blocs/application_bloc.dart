import 'package:flutter/material.dart';
import 'package:flutter_appp/models/place_search.dart';
import 'package:flutter_appp/services/geolocator_service.dart';
import 'package:flutter_appp/services/places_service.dart';
import 'package:geolocator/geolocator.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeoLocatorService();
  final placesService = PlacesService();

  late Position currentLocation;
  List<PlaceSearch> searchResults = [];

  ApplicationBloc() {
    setCurrentLocation();
  }
  // current location
  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm, double radius) async {
    searchResults = await placesService.getAutoComplete(searchTerm, radius);
    notifyListeners();
  }
}
