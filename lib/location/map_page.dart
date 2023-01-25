import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final double lat;
  final double long;
  MapSample(this.lat, this.long);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();



  Set<Marker> marker = {};

  void _onMapCreate(GoogleMapController controller){
    setState(() {
      marker.add(Marker(
          markerId: MarkerId('id_1'),
          position: LatLng(widget.lat, widget.long),
          infoWindow: InfoWindow(
              snippet: 'MindRiser',
              title: 'MindRiser'
          )
      ));
    });

  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: marker,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _onMapCreate(controller);
        },
      ),

    );
  }


}