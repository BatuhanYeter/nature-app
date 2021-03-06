import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_appp/models/comment.dart';
import 'package:flutter_appp/models/event.dart';
import 'package:flutter_appp/models/place_details.dart';
import 'package:flutter_appp/models/place_search.dart';
import 'package:flutter_appp/models/specific_search.dart';
import 'package:flutter_appp/services/events_service.dart';
import 'package:flutter_appp/services/geolocator_service.dart';
import 'package:flutter_appp/services/marker_service.dart';
import 'package:flutter_appp/services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeoLocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();
  final eventService = EventsService();

  // variables
  late Position currentLocation;
  List<PlaceSearch> searchResults = [];
  StreamController<Place> selectedLocation =
      StreamController<Place>.broadcast();
  StreamController<LatLngBounds> bounds =
      StreamController<LatLngBounds>.broadcast();
  String placeType = '';
  List<Marker> markers = [];
  Map<MarkerId, Marker> navigationMarkers = <MarkerId, Marker>{};
  List<SpecificSearch> homePlaces = [];
  List<SpecificSearch> forestPlaces = [];
  String photoReference = '';
  var events = [];
  var allEvents = [];

  // this gives error: Close instances of `dart.core.Sink`.
  // to fix this, create dispose method

  ApplicationBloc() {
    setLastKnownLocation();
    setCurrentLocation();
    getPlaces();
    getForestPlaces();
    getCurrentEvents();
    getAllEvents();
  }

  Future getCurrentLocation() async {
    final MarkerId markerId = MarkerId('currentLocation');
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(currentLocation.latitude, currentLocation.longitude),
      infoWindow: InfoWindow(title: "Current Location"),
    );
    navigationMarkers[markerId] = marker;
    return currentLocation;
  }

  setLastKnownLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  // current location
  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();

    print("cc");
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

  setPlaceType(String value, bool selected, double radius) async {
    if (selected) {
      placeType = value;
    } else
      placeType = '';

    var places = await placesService.searchNature(placeType, radius);
    if (places.length > 0) {
      var newMarker = markerService.createMarkerFromPlace(places[0]);
      markers.add(newMarker);
    }

    var _bounds = markerService.bounds(Set<Marker>.of(markers));
    bounds.add(_bounds);

    notifyListeners();
  }

  getPlaces() async {
    var places = await placesService.searchNature('nature_park', 250);
    homePlaces = places;
    if (homePlaces.length > 0) {
      homePlaces.forEach((place) {
        final MarkerId markerId = MarkerId(place.placeId);
        final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(place.geometry.location.lat, place.geometry.location.lng),
          infoWindow: InfoWindow(title: place.address),
        );
        navigationMarkers[markerId] = marker;
      });
    }
    notifyListeners();
  }

  getForestPlaces() async {
    var places = await placesService.searchNature('camping', 500);
    forestPlaces = places;
    if(forestPlaces.length > 0){
      forestPlaces.forEach((place) {
        final MarkerId markerId = MarkerId(place.placeId);
        final Marker marker = Marker(
          markerId: markerId,
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng),
          infoWindow: InfoWindow(title: place.address),
        );
        navigationMarkers[markerId] = marker;
      });
    }
    notifyListeners();
  }

  getCurrentEvents() async {
    var myEvents = await eventService.getCurrentEvents() ?? [];
    events = myEvents;
    notifyListeners();
  }

  getAllEvents() async {
    allEvents = await eventService.getEvents() ?? [];
    // print("----------------" + allEvents.length.toString());
    notifyListeners();
  }

  @override
  void dispose() {
    // I need to use this in the page I need -> user_map.dart -> listen: false
    selectedLocation.close();
    bounds.close();
    super.dispose();
  }
}
