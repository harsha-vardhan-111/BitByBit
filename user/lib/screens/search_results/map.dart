import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';

class MapDirection extends StatefulWidget {
  const MapDirection({
    Key? key,
    required this.lon,
    required this.lat,
  }) : super(key: key);

  static String id = "map_direction";

  final double lat, lon;

  @override
  State<MapDirection> createState() => _MapDirectionState();
}

class _MapDirectionState extends State<MapDirection> {
  final Completer<GoogleMapController> _controller = Completer();

  static late CameraPosition _kGooglePlex;
  Position? position;

  @override
  void initState() {
    super.initState();
    // checLocationPermission().then((value) {});
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.lon),
      zoom: 14.4746,
    );
  }

  Future<bool> checLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: const MarkerId("Location"),
            position: LatLng(widget.lat, widget.lon),
          ),
        },
        liteModeEnabled: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Share.share(
              'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.lon}');
        },
        child: const Icon(
          Icons.share,
        ),
      ),
    );
  }
}
