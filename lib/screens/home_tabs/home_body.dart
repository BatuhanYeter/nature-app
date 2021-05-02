import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Image getImage(String? photoReference, int height, int width) {
    final maxWidth = "$width";
    final maxHeight = "$height";
    // print(photoReference);

    if (photoReference != 'null') {
      final url =
          "https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth&maxheight=$maxHeight&photoreference=$photoReference&key=AIzaSyBB6urxKy4DqowYs603axJM2g1joMVmhSY";
      return Image.network(url);
    } else
      return Image.asset('assets/icons/logo.png');
  }

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
              return Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.04)
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, size.width * 0.04),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(FontAwesomeIcons.bookmark),
                            title: Text(applicationBloc.homePlaces[index].name),
                            subtitle: Text(
                              "Somewhere over the rainbow",
                              style:
                                  TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              applicationBloc.homePlaces[index].address,
                            ),
                          ),
                          getImage(applicationBloc
                              .homePlaces[index].photoReference
                              .toString(), (size.height * 0.3).toInt(), (size.width * 0.8).toInt()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02)
                ],
              );
            }));
  }
}
