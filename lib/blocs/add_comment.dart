import 'package:flutter/material.dart';
import 'package:flutter_appp/services/places_service.dart';

class AddComment with ChangeNotifier {
  final placesService = PlacesService();
  void addComment(String comment, String placeId) {
    placesService.addComment(comment, placeId);
    notifyListeners();
  }
}