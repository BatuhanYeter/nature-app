import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/blocs/application_bloc.dart';
import 'package:flutter_appp/models/directions.dart';
import 'package:flutter_appp/services/directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  final String dest;

  const NavigationScreen({Key? key, required this.dest}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late GoogleMapController _mapController;
  Directions? info;

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    var currentLocation = applicationBloc.currentLocation;
    var markers = applicationBloc.navigationMarkers;
    Size size = MediaQuery.of(context).size;
    final MarkerId markerId = MarkerId('currentLocation');
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(currentLocation.latitude, currentLocation.longitude),
      infoWindow: InfoWindow(title: "Current Location"),
    );

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: Stack(children: [
        GoogleMap(
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
          initialCameraPosition: CameraPosition(
              target: LatLng(applicationBloc.currentLocation.latitude,
                  applicationBloc.currentLocation.longitude),
              zoom: 12),
          markers: {marker, markers[MarkerId(widget.dest.toString())]!},
          onMapCreated: (controller) => _mapController = controller,
        ),
        Positioned(
          top: size.height * 0.02,
          right: size.width * 0.04,
          child: IconButton(
              icon: Icon(
                Icons.navigation,
                color: Colors.amber,
                size: size.height * 0.05,
              ),
              onPressed: () async {
                final direction = await DirectionsRepository(dio: Dio())
                    .getDirections(
                        origin: marker.position,
                        dest: markers[MarkerId(widget.dest.toString())]!
                            .position);
                info = direction;

                _mapController.animateCamera(info != null
                    ? CameraUpdate.newLatLngBounds(info!.bounds, 100.0)
                    : CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(applicationBloc.currentLocation.latitude,
                            applicationBloc.currentLocation.longitude),
                        zoom: 12)));
                setState(() {});
              }),
        ),
        if (info != null)
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
          ),
      ]),
    );
  }
}
