import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appp/models/comment.dart';
import 'package:flutter_appp/models/place_details.dart';
import 'package:flutter_appp/models/place_search.dart';
import 'package:flutter_appp/models/specific_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  // I deleted all the keys on the credentials page of google api. 
  final key = 'AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<PlaceSearch>> getAutoComplete(
      String search, double radius) async {
    // /maps/api/place/autocomplete/xml?input -> I need json
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=establishment&radius=$radius&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJSON(place)).toList();
  }

  Future<Place> getPlaceDetails(String placeId) async {
    // /maps/api/place/autocomplete/xml?input -> I need json
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJSON(jsonResult);
  }

  Future<List<SpecificSearch>> searchNature(
      String placeType, double radius) async {
    String query = '';
    if (placeType == 'nature_park')
      query = 'nature+park+lake';
    else if (placeType == 'mountain')
      query = 'mountain+hill';
    else if (placeType == 'picnic')
      query = 'picnic';
    else if (placeType == 'camping')
      query = 'camping';
    else if (placeType == 'hiking')
      query = 'hiking';
    else
      query = 'nature';

    // https://maps.googleapis.com/maps/api/place/textsearch/json?query=park&radius=1000&key=AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&radius=$radius&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;

    // print(jsonResults.map((place) => SpecificSearch.fromJSON(place)).toList());
    return jsonResults.map((place) => SpecificSearch.fromJSON(place)).toList();
  }

  Future addComment(String comment, String placeId) async {
    try {
      User user = auth.currentUser!;
      var comments = FirebaseFirestore.instance.collection('comments');

      var commentData = {
        'placeId': placeId,
        'by': user.uid,
        'comment': comment,
        'date': DateTime.now()
      };
      comments.add(commentData).then((value) => print("Comment Added"));
    } catch (e) {
      print(e.toString());
    }
  }

  Future getComments() async {
    try {
      var comments =
          await FirebaseFirestore.instance.collection('comments').get();
      // print("comments length: " + comments.docs.length.toString());

      return comments.docs
          .map((doc) => Comment(
              placeId: doc['placeId'],
              by: doc['by'],
              comment: doc['comment'],
              time: doc['date'].toDate()))
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }
}
