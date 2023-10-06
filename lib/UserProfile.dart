import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:demoapplication/showdelightlist/ViewDelightList.dart';
import 'package:demoapplication/showdelightlist/ViewDelight_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/app_database.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  bool edit = false;
  String km_mile = "Kilometers";
  late String _name = "",city = "",state = "",countary = "",mobileNo = "";
  late bool islogin = false;
  int userId = 0;

  List<ViewDelightList> viewdelightlist = [];

  List<String> elightlistName = [];

  void showDelightList() async{

    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String str_userId = userId.toString();

    http.Response response = await ViewDelight_List().getDelightList("2");
    var jsonResponse = json.decode(response.body);
    var delightlistResponse = ViewDelightList.fromJson(jsonResponse);

    if(delightlistResponse.userInfo!.isNotEmpty){
      
      for(int i=0;i<delightlistResponse.userInfo!.length;i++){

        elightlistName.add(delightlistResponse.userInfo![i].delightName!);
      }
      
    }else{

      print("Delight List Not Found");

    }

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));

  }

  void showData() async {

    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    print(userId);

  //  http.Response? response = await ViewUserDetails().getUserDetails(userId);
 //   var jsonResponse = jsonDecode(response!.body);
  //  var userResponse = ViewUserResponse.fromJson(jsonResponse);

 //   _name = userResponse.userInfo!.name!;
 //   state = userResponse.userInfo!.state!;
 //   countary = userResponse.userInfo!.country!;
 //   mobileNo = userResponse.userInfo!.email!;
  //  city = userResponse.userInfo!.city!;

    // Fluttertoast.showToast(
    //     msg: userResponse.message!,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0);

    setState(()   {});

  }

  @override
  void initState() {
    super.initState();
    showDelightList();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(31, 203, 220, 1),
                  Color.fromRGBO(0, 184, 202, 1)
                ]),
          ),
          child: Container(
            child: Stack(children: [
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                        color: Color(0xFFF8F8F8),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 15.0,
                            spreadRadius: 5,
                            offset: Offset( 0, -5,),
                          )
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 70, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(_name,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: IconButton(
                                      onPressed: () {

                                      },
                                      alignment: Alignment.centerRight,
                                      icon: SvgPicture.asset('assets/images/edit-icon.svg', width: 18,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 5.0, //extend the shadow
                                    offset: Offset(
                                      5.0, // Move to right 5  horizontally
                                      5.0, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                                child:Padding(
                                  padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 90,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Email                 ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              ":",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              mobileNo,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[800]),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Country             ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              ":",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              countary,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[800]),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "State                  ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              ":",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              state,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[800]),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "City                    ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              ":",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              city,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[800]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 5.0, //extend the shadow
                                    offset: Offset(
                                      5.0, // Move to right 5  horizontally
                                      5.0, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20,10,10,12),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0,0,0,0),
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: Container(
                                                child: const Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "My delights",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: IconButton(
                                                  onPressed: () {
                                                  },
                                                  alignment: Alignment.centerRight,
                                                  icon: SvgPicture.asset('assets/images/edit-icon.svg', width: 18,),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0,0,0,4),
                                        height: 30,
                                        child: Wrap(
                                          spacing: 10,
                                          children: elightlistName.map((chip) => Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: Colors.black26
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.all(4.0),
                                            child: Text(
                                                chip,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                                )
                                            ),)
                                          ))
                                              .toList(),
                                      )),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.defaultDialog( content: getContent(),
                                //   barrierDismissible: false,
                                //   confirm: confirmBtn(),
                                //   cancel: cancelBtn(),
                                // );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0, // soften the shadow
                                      spreadRadius: 5.0, //extend the shadow
                                      offset: Offset(
                                        5.0, // Move to right 5  horizontally
                                        5.0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(15,5,10,5),
                                  width: MediaQuery.of(context).size.height,
                                  height: 46,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        child: const Center(
                                            child: Icon(
                                              Icons.logout,
                                              size: 22,
                                              color: Colors.red,
                                            )),
                                      ),
                                      const SizedBox(width: 5,),
                                      const Text( "Logout",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Padding(padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.32,
                        top: 100),
                    child: Card(
                        elevation: 5,
                        shadowColor: const Color.fromRGBO(0, 0, 0, 0.4),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(100),
                                bottomLeft: Radius.circular(100),
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100)),
                            side: BorderSide(width: 5, color: Colors.white)),
                        child: Stack(children: [
                          Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/food-image.png'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ))
                        ])),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget getContent() {
    return Column(
      children: const [
        Text("Are you sure! You want to Logout"),
      ],
    );
  }

  Widget confirmBtn() {
    return
      Container (
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
          ),
        ),
        height: 46,
        child: ElevatedButton(
          onPressed: () async {

            SharedPreferences pre = await SharedPreferences.getInstance();
            await pre.clear();
            pre.remove("name");
            pre.remove("mobileNo");
            pre.remove("countary");
            pre.remove("state");
            pre.remove("islogin");
            pre.remove("userId");

            //exit(0);

            //Get.toNamed(RouteHelper.getIntroScreen());
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            minimumSize: Size(
                MediaQuery.of(context).size.width,
                40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  12), // <-- Radius
            ),
          ),
          child: const Text('Confirm',
              style: TextStyle(
                  color: Colors.white, fontSize: 15)),
        ),
      );
  }

  Widget cancelBtn() {
    return
      Container (
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
          ),
        ),
        height: 46,
        child: ElevatedButton(
          onPressed: () {
            //Get.back();
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            minimumSize: Size(
                MediaQuery.of(context).size.width,
                40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  12), // <-- Radius
            ),
          ),
          child: const Text('Cancel',
              style: TextStyle(
                  color: Colors.white, fontSize: 15)),
        ),
      );
  }
}
