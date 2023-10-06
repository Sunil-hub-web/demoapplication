import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/NearByplaces.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:another_flushbar/flushbar_helper.dart';

class UserNearbyLocation extends StatefulWidget {
  const UserNearbyLocation({super.key});

  @override
  State<UserNearbyLocation> createState() => _UserNearbyLocationState();
}

class _UserNearbyLocationState extends State<UserNearbyLocation> {
  final Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;
  late GoogleMapController _mapController;

  GoogleMapController get mapController => _mapController;
  static const CameraPosition cameraPosition =
      CameraPosition(target: LatLng(20.3490, 85.8077), zoom: 14.4465);
  NearByplaces nearByplaces = NearByplaces();
  List<Results> nearbyLocations = [];
  static const kGoogleApiKey = 'AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k';
  String? _currentAddress;
  Set<Marker> marker = {}; //markers for google map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Location"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: cameraPosition,
            markers: displayPrediction(),
            zoomControlsEnabled: true,
            mapToolbarEnabled: true,
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                  onPressed: () async {
                     _determinePosition();
                   // getNearbyPlaces(position.latitude,position.longitude,"10000");
                  },
                  child: const Text("SsarchText")),

              // if (nearByplaces.results != null)
              //   for (int i = 0; i < nearByplaces.results!.length; i++)
              //     nearByPlacesWidget(nearByplaces.results![i])

              Container(
                margin: EdgeInsets.only(
                    left: 7,
                    top: 135,
                    right: 10,
                    bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 600,
                      margin: EdgeInsets.all(5),
                      child: nearbyLocations.isNotEmpty
                          ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: nearbyLocations.length,
                          itemBuilder: (BuildContext context, int index) => GestureDetector(
                            child: SingleChildScrollView(
                              child:  Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin: Alignment(6.123234262925839e-17, 1),
                                        end: Alignment(-1, 6.123234262925839e-17),
                                        colors: [
                                          Color.fromRGBO(255, 255, 255, 255),
                                          Color.fromRGBO(255, 255, 255, 255),
                                        ]),
                                  ),
                                  child:Container(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10,),
                                    width: MediaQuery.of(context).size.width,
                                    height:  150,
                                    child: Card(
                                      elevation:5,
                                      shadowColor: Colors.black26,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1, // 20%
                                            child: Container(
                                              height: MediaQuery.of(context).size.height,
                                              width: (110),
                                              margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                              decoration: const BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12),
                                                ),
                                                // image: DecorationImage(
                                                //   image:
                                                //   AssetImage("assets/images/food-image.png"),
                                                //   fit: BoxFit.cover,
                                                // )
                                              ),
                                              child: Image.network(nearbyLocations[index].icon!,),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2, // 60%
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children:[

                                                      Expanded(
                                                        child: Text(
                                                          nearbyLocations[index].name!,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.normal),
                                                        ),
                                                      ),

                                                      Container (
                                                        height: 30,
                                                        child: TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                          ),
                                                          onPressed: () {},
                                                          child: Row (
                                                            children: <Widget>[
                                                              SvgPicture.asset('assets/images/star.svg', width: 18, color: const Color(0xFFF9BF3A), ),
                                                              const SizedBox(width: 2,),
                                                              nearbyLocations[index].rating != null ? Text(nearbyLocations[index].rating.toString(),
                                                                style: const TextStyle(
                                                                    fontSize: 11,
                                                                    color: Color(0xFF616768),
                                                                    fontWeight: FontWeight.normal),
                                                              ) : const Text("0",
                                                                style: TextStyle(
                                                                    fontSize: 11,
                                                                    color: Color(0xFF616768),
                                                                    fontWeight: FontWeight.normal),
                                                              ),
                                                              // text
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 2,),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Restaurant",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey[500],
                                                            fontWeight: FontWeight.normal),
                                                      ),
                                                      Text(
                                                        " - " + "6 km",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color: Colors.grey[500],
                                                            fontWeight: FontWeight.normal),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 2,),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Closes at 10pm",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey[500],
                                                            fontWeight: FontWeight.normal),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        child: TextButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(50.0),
                                                                  side: const BorderSide(color: Color(0xFFDDE4E4),),
                                                                )
                                                            ),
                                                            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 12, right: 12,)),
                                                          ),
                                                          onPressed: () {},
                                                          child: Row (
                                                            children: <Widget>[
                                                              SvgPicture.asset('assets/images/direction-icon.svg', width: 18, color: const Color(0xFF00B8CA), ),
                                                              const SizedBox(width: 5,),
                                                              const Text("Directions",
                                                                style: TextStyle(
                                                                    fontSize: 11,
                                                                    color: Color(0xFF00B8CA),
                                                                    fontWeight: FontWeight.normal),
                                                              ), // text
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Container(
                                                        height: 36,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(25),
                                                          gradient: const LinearGradient(
                                                              begin: Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                              colors: [
                                                                Color.fromRGBO(31, 203, 220, 1),
                                                                Color.fromRGBO(0, 184, 202, 1)
                                                              ]),
                                                        ),
                                                        child: TextButton(
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Colors.white,
                                                            padding: const EdgeInsets.only(left: 12, right: 12, top: 5.0, bottom: 5.0),
                                                            textStyle: const TextStyle(fontSize: 13),
                                                          ),
                                                          onPressed: () {},
                                                          child: Row (
                                                            children: <Widget>[
                                                              SvgPicture.asset('assets/images/Pin-s.svg', width: 11, color: Colors.white, ),
                                                              const SizedBox(width: 5,),
                                                              const Text("Pinned",
                                                                style: TextStyle(
                                                                    fontSize: 13,
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.normal),
                                                              ), // text
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ))
                          : Text(""),
                    )
                  ],
                ),
              )
            ],
          )
        ],
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
    _getAddressFromLatLng(position);

    double latitude1 = position.latitude;
    double longitude1 = position.longitude;
    String radius = "10000";

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude1,$longitude1&radius=$radius&key=$kGoogleApiKey');
    var response = await http.get(url);
    nearByplaces = NearByplaces.fromJson(jsonDecode(response.body));

    if(nearByplaces.results != null){
      for(int i = 0;i<nearByplaces.results!.length;i++){
        nearbyLocations.add(nearByplaces.results![i]);
      }
    }
    setState(() {});

    return position;
  }

  Widget nearByPlacesWidget(Results? result) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            begin: Alignment(6.123234262925839e-17, 1),
            end: Alignment(-1, 6.123234262925839e-17),
            colors: [
              Color.fromRGBO(238, 236, 236, 1.0),
              Color.fromRGBO(238, 236, 236, 1.0),
            ]),
      ),
      child: Column(
        children: <Widget>[
          Text("Name : ${result!.name!}"),
          Text("Location : ${result.geometry!.location!.lat!} , ${result.geometry!.location!.lng!}"),
          Text(result.openingHours != null ? "open" : "close"),
          Text("Reating: ${result.rating}")
        ],
      ),
    );
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';

      });
    }).catchError((e) {
      debugPrint(e);
    });

    setState(() {});
  }

  Set<Marker> displayPrediction() {

    marker.clear();

    if (nearbyLocations.isNotEmpty) {
      for (int i = 0; i < nearbyLocations.length; i++) {
        setState(() {
          marker.add(Marker(
              onTap: () {

              },
              markerId: MarkerId(nearbyLocations[i].placeId!),
              position: LatLng(nearbyLocations[i].geometry!.location!.lat!,
                  nearbyLocations[i].geometry!.location!.lng!),
              infoWindow: InfoWindow(
                  title: nearbyLocations[i].name!,
                  snippet: nearbyLocations[i].vicinity!)
          )
          );
          mapController.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(nearbyLocations[i].geometry!.location!.lat!,
                  nearbyLocations[i].geometry!.location!.lng!),
              14.0));
        });
      }
    } else {
      marker.clear();
    }
    return marker;
  }

  void show_Custom_Flushbar(BuildContext context) {
    Flushbar(
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8),
      backgroundGradient: LinearGradient(
        colors: [Colors.green.shade800, Colors.greenAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'This is a floating Flushbar',
      message: 'Lorem ipsum dolor sit amet',
    )..show(context);
  }
}
