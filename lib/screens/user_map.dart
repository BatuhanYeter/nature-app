import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class UserMap extends StatefulWidget {
  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  double _radius = 0;
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: googleMapUI());
  }

  Widget googleMapUI() {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search Location",
                suffixIcon: Icon(FontAwesomeIcons.search)),
            onChanged: (val) => applicationBloc.searchPlaces(val, _radius),
          ),
        ),
        Stack(
          children: [
            Container(
              height: size.height * 0.55,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(applicationBloc.currentLocation.latitude,
                        applicationBloc.currentLocation.longitude),
                    zoom: 18),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (GoogleMapController controller) {},
                mapType: MapType.normal,
              ),
            ),
            if (applicationBloc.searchResults.length != 0)
              Container(
                height: size.height * 0.55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    backgroundBlendMode: BlendMode.darken),
              ),
              Container(
              height: size.height * 0.55,
              width: double.infinity,
              child: ListView.builder(
                itemCount: applicationBloc.searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      applicationBloc.searchResults[index].description,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Search distance", style: TextStyle(fontSize: 24),),
            Slider(
              value: _radius,
              min: 0,
              max: 5000,
              divisions: 100,
              label: _radius.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _radius = value;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
