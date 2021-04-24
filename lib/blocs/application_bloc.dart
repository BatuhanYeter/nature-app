import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_appp/models/place_details.dart';
import 'package:flutter_appp/models/place_search.dart';
import 'package:flutter_appp/services/geolocator_service.dart';
import 'package:flutter_appp/services/places_service.dart';
import 'package:geolocator/geolocator.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeoLocatorService();
  final placesService = PlacesService();

  // variables
  late Position currentLocation;
  List<PlaceSearch> searchResults = [];
  StreamController<Place> selectedLocation = StreamController<Place>();
  // this gives error: Close instances of `dart.core.Sink`.
  // to fix this, create dispose method

  Future getCurrentLocation() async {
    return currentLocation;
  }
  ApplicationBloc() {
    setLastKnownLocation();
    setCurrentLocation();
  }
  setLastKnownLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
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

  setSelectedLocation(String placeId) async {
    selectedLocation.add(await placesService.getPlaceDetails(placeId));
    searchResults = [];
    notifyListeners();
  }
  @override
  void dispose() {
    // I need to use this in the page I need -> user_map.dart -> listen: false
    selectedLocation.close();
    super.dispose();
  }
}
