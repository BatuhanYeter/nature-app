import 'package:flutter/cupertino.dart';
import 'package:flutter_appp/models/place_details.dart';
import 'package:flutter_appp/models/place_search.dart';
import 'package:flutter_appp/models/specific_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY';

  Future<List<PlaceSearch>> getAutoComplete(String search, double radius) async {
    // /maps/api/place/autocomplete/xml?input -> I need json
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=establishment&radius=$radius&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJSON(place)).toList();
  }

  Future<Place> getPlaceDetails(String placeId) async {
    // /maps/api/place/autocomplete/xml?input -> I need json
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJSON(jsonResult);
  }

  Future<List<SpecificSearch>> searchNature(String placeType, double radius) async {
    String query = '';
    if(placeType == 'nature_park') query = 'nature+park';
    else if(placeType == 'mountain') query = 'mountain+hill';
    else if(placeType == 'picnic') query = 'picnic';
    else if(placeType == 'camping') query = 'camping';
    else if(placeType == 'hiking') query = 'hiking';
    else query = 'nature';

    // https://maps.googleapis.com/maps/api/place/textsearch/json?query=park&radius=1000&key=AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&radius=$radius&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;

    // print(jsonResults.map((place) => SpecificSearch.fromJSON(place)).toList());
    return jsonResults.map((place) => SpecificSearch.fromJSON(place)).toList();
  }

  Future<String> getPlacePhotoReference(String placeId) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=photo&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json["result"]["photos"][0]["photo_reference"];
    return jsonResult;
  }



}