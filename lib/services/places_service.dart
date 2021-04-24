import 'package:flutter_appp/models/place_details.dart';
import 'package:flutter_appp/models/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY';

  Future<List<PlaceSearch>> getAutoComplete(String search, double radius) async {
    // /maps/api/place/autocomplete/xml?input -> I changed xlm to json
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=establishment&location=37.76999,-122.44696&radius=$radius&strictbounds&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJSON(place)).toList();
  }

  Future<Place> getPlaceDetails(String placeId) async {
    // /maps/api/place/autocomplete/xml?input -> I changed xlm to json
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJSON(jsonResult);
  }
}