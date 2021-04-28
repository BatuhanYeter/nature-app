import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:flutter_appp/models/place_details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class UserMap extends StatefulWidget {
  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  double _radius = 500;
  Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSub;
  late StreamSubscription boundsSub;
  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    locationSub = applicationBloc.selectedLocation.stream.listen((place) {
      _goToPlace(place);
    });
    boundsSub = applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    locationSub.cancel();
    boundsSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
        future: applicationBloc.getCurrentLocation(),
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return googleMapUI();
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ],
              ),
            );
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
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
              height: size.height * 0.50,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(applicationBloc.currentLocation.latitude,
                        applicationBloc.currentLocation.longitude),
                    zoom: 18),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
                mapType: MapType.normal,
                markers: Set<Marker>.of(applicationBloc.markers),
              ),
            ),
            if (applicationBloc.searchResults.length != 0)
              Container(
                height: size.height * 0.50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    backgroundBlendMode: BlendMode.darken),
              ),
            if (applicationBloc.searchResults.length != 0)
              Container(
                height: size.height * 0.50,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: applicationBloc.searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        applicationBloc.setSelectedLocation(
                            applicationBloc.searchResults[index].placeId);
                      },
                      title: Text(
                        applicationBloc.searchResults[index].description,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Find the nearest", style: TextStyle(fontSize: size.width * 0.06, fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: size.width * 0.02,
            children: [
              FilterChip(
                label: Text('Nature Park'),
                onSelected: (val) =>
                    applicationBloc.setPlaceType('nature_park', val, _radius),
                selected: applicationBloc.placeType == 'nature_park',

              ),
              FilterChip(
                label: Text('Camping'),
                onSelected: (val) =>
                    applicationBloc.setPlaceType('camping', val, _radius),
                selected: applicationBloc.placeType == 'camping',

              ),
              FilterChip(
                label: Text('Mountain'),
                onSelected: (val) =>
                    applicationBloc.setPlaceType('mountain+hill', val, _radius),
                selected: applicationBloc.placeType == 'mountain+hill',

              ),
              FilterChip(
                label: Text('Picnic'),
                onSelected: (val) =>
                    applicationBloc.setPlaceType('picnic', val, _radius),
                selected: applicationBloc.placeType == 'picnic',

              ),
              FilterChip(
                label: Text('Hiking'),
                onSelected: (val) =>
                    applicationBloc.setPlaceType('hiking', val, _radius),
                selected: applicationBloc.placeType == 'hiking',

              ),

            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Radius $_radius m",
              style: TextStyle(fontSize: 24),
            ),
            Slider(
              value: _radius,
              min: 500,
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

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 14.0)));
  }
}
