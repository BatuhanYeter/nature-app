class Location {
  final double lat;
  final double lng;
  // api: https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4
  // models should be created from inside to out
  Location({required this.lat, required this.lng});

  factory Location.fromJSON(Map<dynamic, dynamic> parsedJson) {
    return Location(lat: parsedJson['lat'], lng: parsedJson['lng']);
  }
}