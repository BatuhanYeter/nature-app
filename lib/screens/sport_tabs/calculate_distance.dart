import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:flutter_appp/models/directions.dart';
import 'package:flutter_appp/services/directions_repository.dart';
import 'package:flutter_appp/services/geolocator_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CalculateDistance extends StatefulWidget {
  const CalculateDistance({Key? key}) : super(key: key);

  @override
  _CalculateDistanceState createState() => _CalculateDistanceState();
}

class _CalculateDistanceState extends State<CalculateDistance> {
  final GeoLocatorService geoLocatorService = GeoLocatorService();

  Completer<GoogleMapController> _controller = Completer();
  Marker? destination;
  Directions? info;

  @override
  void initState() {
    geoLocatorService.getCurrentLocationStream().listen((position) {
      centerScreen(position);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    var currentLocation = applicationBloc.currentLocation;
    Size size = MediaQuery.of(context).size;
    /*
    StreamBuilder<Position>(
        stream: geoLocatorService.getCurrentLocationStream(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          if(snapshot.hasData != true) return Center(child: CircularProgressIndicator(),);
          return Center(child: Text("${snapshot.data!.latitude}"));
        },
      )
     */
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(applicationBloc.currentLocation.latitude,
                      applicationBloc.currentLocation.longitude),
                  zoom: 18),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {
                if(destination != null) destination!,
              },
              onTap: _addMarker,
              polylines: {
                if (info != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: Colors.red,
                    width: 5,
                    points: info!.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
            ),
          ),
          if (info == null)
            Positioned(
              top: size.height * 0.02,
              left: size.width * 0.04,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                  horizontal: size.width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(size.width * 0.06),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  'Please tap on somewhere on map to mark the destination',
                  style: TextStyle(
                    fontSize: size.width * 0.034,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          else
            Positioned(
              top: size.height * 0.02,
              left: size.width * 0.04,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                  horizontal: size.width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(size.width * 0.06),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${info!.totalDistance}, ${info!.totalDuration}',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
  }

  void _addMarker(LatLng pos) async {
    final applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    var currentLocation = applicationBloc.currentLocation;
    final MarkerId markerId = MarkerId('currentLocation');
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(currentLocation.latitude, currentLocation.longitude),
      infoWindow: InfoWindow(title: "Current Location"),
    );
    setState(() {
      destination = Marker(
        markerId: MarkerId("destination"),
        position: pos,
        infoWindow: InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
      );
    });

    final direction = await DirectionsRepository(dio: Dio())
        .getDirections(
        origin: marker.position,
        dest: pos);
    info = direction;
    setState(() {
    });
  }
}
