import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// GoogleMaps kullanabilmek için AndroidManifest.xml ve app level gradle
// üzerinde bazı değişiklikler yapıldı ve eklentiler oldu
// TODO: iOS için de aynı adımları izlemek lazım. google_maps_flutter package sayfası yoluyla
class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),

      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(41.278033, 28.008386),
          zoom: 18
        ),
        onMapCreated: (GoogleMapController controller) {

        },
        mapType: MapType.satellite,
      ),
    );
  }
}
