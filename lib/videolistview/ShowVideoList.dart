import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../videorecording/FileCompressionApi.dart';
import 'ShowVideoReviewResponse.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'VideoReviewDetailsScreen.dart';
import 'ViewVideoReview.dart';

class ShowVideoList extends StatefulWidget {
  const ShowVideoList({super.key});

  @override
  State<ShowVideoList> createState() => _ShowVideoListState();
}

class _ShowVideoListState extends State<ShowVideoList> {
  List<VideoReviewDetails> videoreviewDet = [];
  String placeId = "", filePath1 = "";
  int userId = 0, videoreviewlength = 0;
  List<String?> imageFilepath = [];

  Future<List<VideoReviewDetails>> getVideoReview() async {
    videoreviewDet.clear();

    SharedPreferences pre = await SharedPreferences.getInstance();
    placeId = pre.getString("placeId") ?? "";
    userId = pre.getInt("userId") ?? 0;
    bool isVisible = false;

    String strUserid = userId.toString();

    http.Response? response = await ViewVideoReview()
        .viewVideoReview("10", "ChIJsdRyk7AJGToRVqKTJLymGjo");
    var jsonResponse = json.decode(response!.body);
    var videoreviewResponse = ShowVideoReviewResponse.fromJson(jsonResponse);

    if (videoreviewResponse.videoReviewDetails!.isNotEmpty) {
      for (int i = 0; i < videoreviewResponse.videoReviewDetails!.length; i++) {
        videoreviewDet.add(videoreviewResponse.videoReviewDetails![i]);
        showvideoPath(videoreviewResponse.videoReviewDetails![i].video);
      }

      videoreviewlength = videoreviewDet.length;
      isVisible = true;
    } else {
      Fluttertoast.showToast(
          msg: videoreviewResponse.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      isVisible = false;
    }

    print("videodetails $videoreviewDet");

    return videoreviewDet;
  }

  Future<void> showvideoPath(String? videoPath) async {
    var uint8list = await VideoThumbnail.thumbnailFile(
      video: videoPath ?? "",
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 100,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    print("yourimagepath   $uint8list");

    // final file = File(uint8list!);
    //filePath1 = file.path;
    imageFilepath.add(uint8list);

    print("filepathimage   ${imageFilepath}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Video Details"),
      ),
      body: Column(
        children: [
          const Text(
            "Video Reviews & Rating",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
              height: 200,
              child: FutureBuilder(
                future: getVideoReview(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: videoreviewDet.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async {
                            var uint8list = await VideoThumbnail.thumbnailFile(
                              video: "https://www.profileace.com/wherenx_user/public/${videoreviewDet[index].video!}" ?? "",
                              thumbnailPath:
                                  (await getTemporaryDirectory()).path,
                              imageFormat: ImageFormat.WEBP,
                              maxHeight: 200,
                              // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
                              quality: 75,
                            );
                            print("yourimagepath   $uint8list");

                            setState(() {
                              final file = File(uint8list!);
                              filePath1 = file.path;
                            });

                            print("filepathimage   ${filePath1}");

                            // SharedPreferences pre =
                            //     await SharedPreferences.getInstance();
                            // pre.setString(
                            //     "videoreview", videoreviewDet[index].video!);
                            // pre.setString(
                            //     "videorating", videoreviewDet[index].rating!);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             VideoReviewDetailsScreen(
                            //                 filePath:
                            //                     videoreviewDet[index].video!,
                            //                 videorating:
                            //                     videoreviewDet[index].rating!,
                            //                 videoDate: videoreviewDet[index]
                            //                     .reviewDate!,
                            //                 videoName: videoreviewDet[index]
                            //                     .reviewerName!)));
                          },
                          child: Container(
                            width: 140,
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              shadowColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: /*FileImage(File(imageFilepath[index]!))*/
                                          AssetImage(
                                              "assets/images/videoReview.jpg"),
                                      fit: BoxFit.cover,
                                    )),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1),
                                  child: RatingBarIndicator(
                                    rating: double.parse(
                                        videoreviewDet[index].rating!),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )),
          Container(
            margin: EdgeInsets.all(10),
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.file(File(filePath1)),
          )
        ],
      ),
    );
  }

  Widget showVideoPeriview(int index) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          width: 200,
          height: 500,
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: RatingBarIndicator(
                  rating: double.parse(videoreviewDet[index].rating!),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              )
            ],
          ),
        ));
  }
}
