import 'dart:convert';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:demoapplication/model/NearByplaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_geocoder_alternative/flutter_geocoder_alternative.dart';
import 'package:dio/dio.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class NearByPlacesOnmap extends StatefulWidget {
  const NearByPlacesOnmap({super.key});

  @override
  State<NearByPlacesOnmap> createState() => _NearByPlacesOnmapState();
}

class _NearByPlacesOnmapState extends State<NearByPlacesOnmap> {
  String apikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";
  String radius = "1000";
  double latitude = 20.3534;
  double longitude = 85.8268;
  String restaurant = "restaurant";
  String address = "";

  NearByplaces nearByplaces = NearByplaces();

  convertToAddress(double lat, double long, String apikey) async {
    Dio dio = Dio();  //initilize dio package
    String apiurl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apikey";

    Response response = await dio.get(apiurl); //send get request to API URL

    if(response.statusCode == 200){ //if connection is successful
      Map data = response.data; //get response data
      if(data["status"] == "OK"){ //if status is "OK" returned from REST API
        if(data["results"].length > 0){ //if there is atleast one address
          Map firstresult = data["results"][0]; //select the first address

          address = firstresult["formatted_address"]; //get the address

          //you can use the JSON data to get address in your own format

          setState(() {
            //refresh UI
          });
        }
      }else{
        print(data["error_message"]);
      }
    }else{
      print("error while fetching geoconding data");
    }
  }

  @override
  void initState() {
   // convertToAddress(latitude, longitude, apikey); //call convert to address
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Places"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  getNearbyPlaces();
                },
                child: const Text("Get Nearby Places")),

        if (nearByplaces.results != null)
      for (int i = 0; i < nearByplaces.results!.length; i++)
        nearByPlacesWidget(nearByplaces.results![i]),


          ],
        ),
      ),
    );
  }

  void getNearbyPlaces() async {
    // var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + radius + '&key=' + apikey);

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=$restaurant&keyword="cruise"&key=$apikey');
    var response = await http.get(url);
    nearByplaces = NearByplaces.fromJson(jsonDecode(response.body));

    setState(() {});

    //"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY"
  }

  Widget nearByPlacesWidget(Results? result) {

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 10,
            spreadRadius: 10,
            offset: Offset(0, 15),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            begin: Alignment(6.123234262925839e-17, 1),
            end: Alignment(-1, 6.123234262925839e-17),
            colors: [
              Color.fromRGBO(238, 236, 236, 1.0),
              Color.fromRGBO(238, 236, 236, 1.0),
            ]),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            height:100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(255, 255, 255, 1.0),
                Color.fromRGBO(255, 255, 255, 1.0),
              ]),
            ),
            child: result!.photos?[0].photoReference == null
                ? Image.network(result.icon!, height: 100, width: 100,)
                : getImage("${result.photos?[0].photoReference}")/*Image.network(result!.icon!, height: 100, width: 100)*/,
          ),

          /* Image.network(
              result!.icon!,
              height: 100,
              width: 100
          ),*/

          Expanded(
            child: Container(
              width: 207,
              height: 100,
              margin: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(255, 255, 255, 1.0),
                  Color.fromRGBO(255, 255, 255, 1.0),
                ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(4), //apply padding to all four sides
                    child: Text(
                      "${result.name!}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4), //apply padding to all four sides
                    child: Text(result.openingHours != null ? "open" : "close"),
                  ),
                /*  Padding(
                    padding: EdgeInsets.all(4), //apply padding to all four sides
                    child: result.rating == null  ? Text("") : RatingBarIndicator(
                      rating: double.parse(result.rating.toString()),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.all(2), //apply padding to all four sides
                    child: Text("${result.types?[0]}"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getAddress(double pLon, double pLat) {
    Geocoder geocoder = Geocoder();
    return geocoder.getAddressFromLonLat(pLon, pLat);
  }

Future<void> _showAddress(String latitude,String longitude) async {
    //var _address = await getAddress(-6.1805312, 106.8282181);

    // converted the lat from string to double
    double lat_data = double.parse(latitude);
    // converted the lon from string to double
    double lon_data = double.parse(longitude);

    /*List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    //address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    address = '${place.subLocality},${place.locality},${place.country}';
*/

    const _apiKey = 'AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k';
    final LocatitonGeocoder geocoder = LocatitonGeocoder(_apiKey);
    final address11 = await geocoder
        .findAddressesFromCoordinates(Coordinates(lat_data, lon_data));
    print(address11.first.addressLine);
    address = address11.first.addressLine!;

    //return address.first.addressLine;
  }

  //"https://maps.googleapis.com/maps/api/place/photo?maxwidth=4000&photo_reference=AUacShjy2oRJwsB6m69uDzCpu_fYmtFXO50cxniJAgWk1Q8VzWQXq5MVWgn6ktiTdjcaABdqFuqxcX5wvCDl036jZPBrc1UsIeMBwvk7kw7ca5QzIyKQuUymCPRDBkj4xDvVzLJ--Pe2ckWb2W7lkwMkLbUb_qdxpgr4MlEBUKs-PUaWLqKH&key=AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k"

  Image getImage(String photo_reference){

    final baseurl = "https://maps.googleapis.com/maps/api/place/photo";
    final maxWidth = "100";
    final maxHeight = "100";
    final url = "$baseurl?maxwidth=$maxWidth&maxheight=$maxHeight&photo_reference=$photo_reference&key=AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";
    return Image.network(url,fit: BoxFit.fill,);
  }
}
