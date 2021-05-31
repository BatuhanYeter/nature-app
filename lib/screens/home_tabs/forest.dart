import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/add_comment.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:flutter_appp/services/places_service.dart';
import 'package:flutter_appp/widgets/comments_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Forest extends StatefulWidget {
  @override
  _ForestState createState() => _ForestState();
}

class _ForestState extends State<Forest> {
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
    final addCommentBloc = Provider.of<AddComment>(context);
    final placesService = PlacesService();
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        height: size.height,
        child: ListView.builder(
            itemCount: applicationBloc.forestPlaces.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.04)),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, size.width * 0.04),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(FontAwesomeIcons.bookmark),
                            title: Text(applicationBloc.forestPlaces[index].name),
                            subtitle: Text(
                              "Somewhere over the rainbow",
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              applicationBloc.forestPlaces[index].address,
                            ),
                          ),
                          getImage(
                              applicationBloc.forestPlaces[index].photoReference
                                  .toString(),
                              (size.height * 0.3).toInt(),
                              (size.width * 0.8).toInt()),
                          FutureBuilder(
                              future: placesService.getComments(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                return CommentsList(
                                  placeId:
                                  applicationBloc.forestPlaces[index].placeId,
                                );
                              }),
                          FutureBuilder(
                              future: placesService.getComments(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    onSubmitted: (String comment) {
                                      addCommentBloc.addComment(
                                          comment,
                                          applicationBloc
                                              .forestPlaces[index].placeId);
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Add comment"),
                                  ),
                                );
                              })
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
