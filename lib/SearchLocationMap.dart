import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:http/http.dart' as http;
import 'package:demoapplication/model/NearByplaces.dart';


class SearchLocationMap extends StatefulWidget {
  const SearchLocationMap({super.key});

  @override
  State<SearchLocationMap> createState() => _SearchLocationMapState();
}

const kGoogleApiKey = 'AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k';

class _SearchLocationMapState extends State<SearchLocationMap> {
  static const CameraPosition cameraPosition =
      CameraPosition(target: LatLng(20.3490, 85.8077), zoom: 14.4465);
  Set<Marker> marker = {};
  late GoogleMapController controllerMap;
  final Mode _mode = Mode.overlay;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  late String _currentAddress;

  NearByplaces nearByplaces = NearByplaces();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text("Search Location"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: cameraPosition,
            markers: marker,
            zoomControlsEnabled: true,
            mapToolbarEnabled: true,
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              controllerMap = controller;
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _handelerPressButton();

                  },
                  child: const Text("SsarchText")),

              if (nearByplaces.results != null)
                for (int i = 0; i < nearByplaces.results!.length; i++)
                  nearByPlacesWidget(nearByplaces.results![i])

             /* ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text("View Text")),*/
            ],
          )
        ],
      ),
    );
  }

  Future<void> _handelerPressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        radius: 10000000,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        //components: [Component(Component.country, "pk"),Component(Component.country, "usa"),Component(Component.country, "en")]
        components: [
          Component(Component.country, "ind"),
          Component(Component.country, "usa")
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState
        ?.showBottomSheet((context) => Text(response.errorMessage!));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse placesDetailsResponse =
        await places.getDetailsByPlaceId(p.placeId!);

    final lat = placesDetailsResponse.result.geometry?.location.lat;
    final lng = placesDetailsResponse.result.geometry?.location.lng;

    marker.clear();
    marker.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat!, lng!),
        infoWindow:
            InfoWindow(title: placesDetailsResponse.result.formattedAddress)));
    setState(() {});

    controllerMap
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat!, lng!), 14.0));

    getNearbyPlaces(lat,lng,"20");

  }

  /*  openAlertBox(Results? result) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "User Id :" + todo.id.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "User Name :" + todo.name.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Mobile No :" + todo.mobileno.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Choose1 :" + todo.choose1.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Choose2 :" + todo.choose2.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),

                  //  SizedBox(
                  //   height: 5.0,
                  // ),
                  //   Divider(
                  //   color: Colors.grey,
                  //   height: 4.0,
                  // ),
                  // SizedBox(
                  //   height: 5.0,
                  // ),

                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0)),
                      ),
                      child: Text(
                        "User Details",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }*/

  void getNearbyPlaces(double latitude,double longitude,String radius) async {
    // var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + radius + '&key=' + apikey);

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&key=$kGoogleApiKey');
    var response = await http.get(url);
    nearByplaces = NearByplaces.fromJson(jsonDecode(response.body));

    setState(() {});

    //"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY"
  }

  Widget nearByPlacesWidget(Results? result) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
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

  Widget nearByPlacesWidget1(Results? result) {
    return ListView.builder(
        itemCount: nearByplaces.results?.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                //color: Colors.transparent,
                //shadowColor: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      top: 10, right: 10, left: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Name : ${result!.name!}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Location : ${result.geometry!.location!.lat!} , ${result.geometry!.location!.lng!}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            result.openingHours != null ? "open" : "close",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Reating: ${result.rating}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

/*  TextFormField(
  decoration: textInputDecoration.copyWith(
  hintText: "Enter Company Address",
  prefixIcon: Icon(Icons.map),
  ),
  onTap: () async {
  Prediction p = await PlacesAutocomplete.show(
  context: context,
  radius: 10000000,
  types: [],
  strictbounds: false,
  apiKey: kGoogleApiKey,
  mode: Mode.overlay,
  language: "en",
  components: [Component(Component.country, "nz")],
  );
  },
  validator: (val) =>
  val.isEmpty ? 'Enter address' : null,
  onChanged: (val) async {
  setState(() => address = val);
  },
  ),*/
}
