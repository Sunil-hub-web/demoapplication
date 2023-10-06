import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class CurrentLocationFlutter extends StatefulWidget {
  const CurrentLocationFlutter({super.key});

  @override
  State<CurrentLocationFlutter> createState() => _CurrentLocationFlutterState();
}

class _CurrentLocationFlutterState extends State<CurrentLocationFlutter> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(20.3490, 85.8077), zoom: 14);

 // Set<Marker> marker = {};
  late GoogleMapController googleMapController;
  late LatLng _latLng;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  /*static const CameraPosition _kGooglePlex1 = CameraPosition(
    target: LatLng(20.3490, 85.8077),
    zoom: 14.4746,
  );*/

  CameraPosition _kGooglePlex1 = CameraPosition(
    target: LatLng(20.3490, 85.8077),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(20.3490, 85.8077),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414

  );

  @override
  void initState() {
    super.initState();
    getLocationCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Current Location"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: <Marker>{
          _setMarker()
        },
        zoomControlsEnabled: false,
        mapType: MapType.hybrid,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _goToTheLake();

          /* Position position = await _determinePosition();
            googleMapController.animateCamera(CameraUpdate.newCameraPosition
              (CameraPosition(target: LatLng(position.latitude,position.longitude),zoom: 15)));

            marker.clear();
            marker.add(Marker(markerId: const MarkerId("CurrentPosition"),position: LatLng(position.latitude,position.longitude)));
            setState(() {});*/
        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabler;
    LocationPermission permission;

    serviceEnabler = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabler) {
      return Future.error("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission is denide");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission is deniedForever");
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  _setMarker() {
    return Marker(
        markerId: MarkerId("Marker _ 1"),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(20.3490, 85.8077)

    );
  }

  Future<void> getLocationCurrent() async {

    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    _latLng = LatLng(_locationData.latitude!, _locationData.longitude!);

    _kGooglePlex1 = CameraPosition(
        target: _latLng,
        zoom: 14.4666
    );

    setState(() { });

  }
}
