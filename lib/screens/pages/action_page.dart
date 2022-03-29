import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const initialCameraPosition =
      CameraPosition(target: LatLng(0.1141423, 29.2749995), zoom: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nos distributeurs"),
      ),
      body: const GoogleMap(
        initialCameraPosition: initialCameraPosition,
      ),
    );
  }
}
