import 'dart:convert';

import 'package:demoapplication/model/SerachByQuery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuerySerachOnGoogleMap extends StatefulWidget {
  const QuerySerachOnGoogleMap({super.key});

  @override
  State<QuerySerachOnGoogleMap> createState() => _QuerySerachOnGoogleMapState();
}

class _QuerySerachOnGoogleMapState extends State<QuerySerachOnGoogleMap> {
  TextEditingController editingController = TextEditingController();
  SerachByQuery serachByQuery = SerachByQuery();
  List<Results> serachByQueryLocation = [];
  bool isVisible = false;
  String googleApikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";

  @override
  void initState() {
   _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 35),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (value) async {
                  // var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + radius + '&key=' + apikey);

                  Position position = await _determinePosition();
                  double latitude = position.latitude;
                  double longitide = position.longitude;

                  var url = Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?query=$value&location=$latitude,$longitide&radius=1000&key=AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k');

                  var response = await http.get(url);
                  serachByQuery = SerachByQuery.fromJson(jsonDecode(response.body));

                  serachByQueryLocation.clear();

                  if (serachByQuery.results != null) {
                    for (int i = 0; i < serachByQuery.results!.length; i++) {
                      serachByQueryLocation.add(serachByQuery.results![i]);
                    }
                  }

                  setState(() {});
                },
                controller: editingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFA1A8A9),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
             child:  Expanded(
                child: Container(
                //margin: EdgeInsets.only(left: 7, top: 10, right: 10, bottom: 0),
                child: serachByQueryLocation.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                              height: MediaQuery.of(context).size.height / 1.3,
                              margin: EdgeInsets.all(5),
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: serachByQueryLocation.length,
                                  itemBuilder:
                                      (context, int index) => GestureDetector(
                                            onTap: () async {
                                              SharedPreferences pre =
                                                  await SharedPreferences.getInstance();pre.setString("placeId", serachByQueryLocation[index].placeId!);
                                              //save String
                                              //  Get.toNamed(RouteHelper.getdetailsScreen());
                                            },
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
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10,),
                                                    width: MediaQuery.of(context).size.width,
                                                    height: MediaQuery.of(context).size.width / 2.5,
                                                    child: Card(
                                                      elevation: 5,
                                                      shadowColor: Colors.black12,
                                                      color: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 2, // 20%
                                                              child: Container(
                                                                height: 130,
                                                                decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(20)),
                                                                width: 100,
                                                                margin: EdgeInsets
                                                                    .only(top: 10, left: 10, right: 10, bottom: 10),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                  // Image border
                                                                  child: SizedBox.fromSize(size: Size.fromRadius(48),
                                                                    // Image radius
                                                                    child: serachByQueryLocation[index].photos?[0].photoReference == null ? Image
                                                                            .network(serachByQueryLocation[index].icon!, height: 100, width: 100,)
                                                                        : getImage(
                                                                            "${serachByQueryLocation[index].photos?[0].photoReference}",
                                                                            "${serachByQueryLocation[index].photos?[0].width}") /*Image.network(nearbyLocations[index].icon!,)*/,
                                                                  ),
                                                                ),
                                                              )),
                                                          Expanded(
                                                              flex: 3, // 60%
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection: Axis.vertical,
                                                                child: Container(
                                                                  margin: EdgeInsets.only(left: 2, right: 2, top: 10),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              serachByQueryLocation[index].name!,
                                                                              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height: 30,
                                                                            child: TextButton(
                                                                              style: ButtonStyle(
                                                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                              ),
                                                                              onPressed: () {},
                                                                              child: Row(
                                                                                children: <Widget>[
                                                                                  SvgPicture.asset(
                                                                                    'assets/images/star.svg',
                                                                                    width: 18,
                                                                                    color: Color(0xFFF9BF3A),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 2,
                                                                                  ),
                                                                                  serachByQueryLocation[index].rating != null
                                                                                      ? Text(
                                                                                          serachByQueryLocation[index].rating.toString(),
                                                                                          style: TextStyle(fontSize: 11, color: Color(0xFF616768), fontWeight: FontWeight.normal),
                                                                                        )
                                                                                      : Text(
                                                                                          "0",
                                                                                          style: TextStyle(fontSize: 11, color: Color(0xFF616768), fontWeight: FontWeight.normal),
                                                                                        ),
                                                                                  // text
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: 2,),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            serachByQueryLocation[index].types![0],
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey[500],
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                          Text("",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize: 11,
                                                                                color: Colors.grey[500],
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: 2,),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            serachByQueryLocation[index].businessStatus == "OPERATIONAL" ? "open" : "close",
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey[500],
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                35,
                                                                            child:
                                                                                TextButton(
                                                                              style: ButtonStyle(
                                                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(50.0),
                                                                                  side: BorderSide(
                                                                                    color: Color(0xFFDDE4E4),
                                                                                  ),
                                                                                )),
                                                                                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(
                                                                                  left: 12,
                                                                                  right: 12,
                                                                                )),
                                                                              ),
                                                                              onPressed: () {},
                                                                              child: Row(
                                                                                children: <Widget>[
                                                                                  SvgPicture.asset(
                                                                                    'assets/images/direction-icon.svg',
                                                                                    width: 18,
                                                                                    color: Color(0xFF00B8CA),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text(
                                                                                    "Directions",
                                                                                    style: TextStyle(fontSize: 11, color: Color(0xFF00B8CA), fontWeight: FontWeight.normal),
                                                                                  ),
                                                                                  // text
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 10),
                                                                          Container(
                                                                            height: 36,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(25),
                                                                              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                Color.fromRGBO(31, 203, 220, 1),
                                                                                Color.fromRGBO(0, 184, 202, 1)
                                                                              ]),
                                                                            ),
                                                                            child:
                                                                                TextButton(
                                                                              style: TextButton.styleFrom(
                                                                                foregroundColor: Colors.white,
                                                                                padding: EdgeInsets.only(left: 12, right: 12, top: 5.0, bottom: 5.0),
                                                                                textStyle: TextStyle(fontSize: 13),
                                                                              ),
                                                                              onPressed: () async {},
                                                                              child: Row(
                                                                                children: <Widget>[
                                                                                  SvgPicture.asset(
                                                                                    'assets/images/Pin-s.svg',
                                                                                    width: 11,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text(
                                                                                    "Pinned",
                                                                                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.normal),
                                                                                  ),
                                                                                  // text
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                          )))
                        ],
                      )
                    : Visibility(
                        visible: isVisible,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 7,
                              width: 100,
                              margin: EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                "List Not Found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17, fontFamily: 'Poppins'),
                              ),
                            ))))),
           )

          ],
        ),
      ),
    );
  }

  Image getImage(String photoReference, String maxwidth) {
    var baseurl = "https://maps.googleapis.com/maps/api/place/photo";
    // var maxwidth = "100";
    // var maxHeight = "100";
    final url =
        "$baseurl?maxwidth=$maxwidth&photo_reference=$photoReference&key=$googleApikey";
    return Image.network(
      url,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
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

    double latitude1 = position.latitude;
    double longitude1 = position.longitude;
    String radius = "10000";

    setState(() {});

    return position;
  }
}
