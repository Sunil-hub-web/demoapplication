// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewEventData.dart';
import 'ViewEventResponse.dart';
import 'package:http/http.dart' as http;

class ShowArrayListData extends StatefulWidget {
  const ShowArrayListData({super.key});

  @override
  State<ShowArrayListData> createState() => _ShowArrayListDataState();
}

class _ShowArrayListDataState extends State<ShowArrayListData> {
  String profileImage = "";
  List<ViewEventResponse> visereventresponse = [];
  List<Data> vieweventdata = [];
  late List<PeventImage> priimage;

  Future<List<Data>> showEventData() async {
    vieweventdata.clear();

    http.Response? response = await ViewEventData().getEventData();
    var jsonResponse = json.decode(response!.body);
    var eventdataresponse = ViewEventResponse.fromJson(jsonResponse);

    if (eventdataresponse.status == "200") {
      if (eventdataresponse.data!.isNotEmpty) {
        for (int i = 0; i < eventdataresponse.data!.length; i++) {
          vieweventdata.add(eventdataresponse.data![i]);
           priimage = [];
          for(int j=0;j<eventdataresponse.data![i].peventImage!.length;j++){
            priimage.add(eventdataresponse.data![i].peventImage![j]);
          }
        }
      }
    }

    print("userdatalist ${vieweventdata.toString()}");
    print("userdatalistiamge ${priimage.toString()}");

    return vieweventdata;
  }

  PageController controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
                future: showEventData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: vieweventdata.length,
                          itemBuilder: (context, int index) {
                            return Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.black12,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PageView.builder(
                                      itemCount: priimage.length,
                                      itemBuilder: (BuildContext context,
                                          int itemIndex) {
                                        return Container(
                                            height: 20,
                                            width: 100,
                                            margin: const EdgeInsets.only(
                                              top: 5,
                                              left: 5,
                                              right: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              // Image border
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(48),
                                                // Image radius
                                                child: Image.network(
                                                   priimage[0].image!,
                                                    fit: BoxFit
                                                        .cover) /*Image.network(nearbyLocations[index].icon!,)*/,
                                              ),
                                            ));
                                      },
                                    ),

                                    // Container(
                                    //     height: 35,
                                    //     width: 100,
                                    //     margin: const EdgeInsets.only(
                                    //       top: 5,
                                    //       left: 5,
                                    //       right: 5,
                                    //     ),
                                    //     decoration: const BoxDecoration(
                                    //       color: Colors.white,
                                    //       borderRadius: BorderRadius.all(
                                    //         Radius.circular(12),
                                    //       ),
                                    //     ),
                                    //     child: ClipRRect(
                                    //       borderRadius:
                                    //           BorderRadius.circular(20),
                                    //       // Image border
                                    //       child: SizedBox.fromSize(
                                    //         size: Size.fromRadius(48),
                                    //         // Image radius
                                    //         child: Image.network(
                                    //           priimage[0].image!,
                                    //             fit: BoxFit
                                    //                 .cover) /*Image.network(nearbyLocations[index].icon!,)*/,
                                    //       ),
                                    //     )
                                    // )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
