import 'package:flutter_appp/models/specific_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {
  LatLngBounds bounds(Set<Marker> markers) {
    return createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce((value, element) => value < element ? value : element); // smallest
    final southwestLon = positions.map((p) => p.longitude).reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce((value, element) => value > element ? value : element); // biggest
    final northeastLon = positions.map((p) => p.longitude).reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon)
    );
  }

  Marker createMarkerFromPlace(SpecificSearch place) {
    var markerId = place.placeId;
    return Marker(
        markerId: MarkerId(markerId),
        draggable: false,
        infoWindow: InfoWindow(title: place.name, snippet: place.address),
        position:
            LatLng(place.geometry.location.lat, place.geometry.location.lng));
  }
}
