import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:flutter_appp/services/places_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeBody extends StatelessWidget {
  /*
  Image getImage(String photoReference) {
    final maxWidth = "400";
    final maxHeight = "200";
    final url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth&photoreference=$photoReference&key=AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY";
    return Image.network(url);
  }
  Future<String> getPlacePhotoReference(String placeId) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=photo&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json["result"]["photos"][0]["photo_reference"];
    String photoReference = jsonResult.toString();
    print("json result:" + jsonResult.toString() + "photoref" + photoReference);
    return jsonResult;
  } */

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        height: size.height,
        child: ListView.builder(
            itemCount: applicationBloc.homePlaces.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        applicationBloc.homePlaces[index].name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(applicationBloc.homePlaces[index].address),
                    ],
                  ),
                ),
              );
            }));
  }
}
