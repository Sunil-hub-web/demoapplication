import 'dart:convert';

import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'RandomColorModel.dart';

class GridViewbuilder extends StatefulWidget {
  const GridViewbuilder({super.key});

  @override
  State<GridViewbuilder> createState() => _GridViewbuilderState();
}

class _GridViewbuilderState extends State<GridViewbuilder> {
  List<String> icon_white = [
    "assets/images/food-w.png",
    "assets/images/health-w.png",
    "assets/images/family-w.png",
    "assets/images/shopping-w.png",
    "assets/images/museum-w.png",
    "assets/images/park-w.png",
    "assets/images/music-w.png",
    "assets/images/drink-w.png",
    "assets/images/sports-w.png",
    "assets/images/films-w.png",
    "assets/images/advanture-w.png",
    "assets/images/Event-w.png",
  ];
  List<String> icon_black = [
    "assets/images/food-g.png",
    "assets/images/health-g.png",
    "assets/images/family-g.png",
    "assets/images/shopping-g.png",
    "assets/images/museum-g.png",
    "assets/images/park-g.png",
    "assets/images/music-g.png",
    "assets/images/drink-g.png",
    "assets/images/sports-g.png",
    "assets/images/films-g.png",
    "assets/images/advanture-g.png",
    "assets/images/Event-g.png",
  ];
  List<String> widgetList = [
    'Food',
    'Health & Fitness',
    'Family & Kids',
    'Shopping',
    'Museums ',
    'Parks',
    'Music',
    'Bar & Night clubs',
    'Sports',
    'Films',
    'Adventure',
    'Events',
  ];

  final controller = DragSelectGridViewController();

  List<String> namelist = [];
  bool isSelected1 = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(rebuild);
  }

  @override
  void dispose() {
    controller.removeListener(rebuild);
    super.dispose();
  }

  void rebuild() => setState(() {});

  int selectedCard = -1;
  List<int> selectedIndex = [];

  @override
  Widget build(BuildContext context) {
   // var isSelected1 = controller.value.isSelecting;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid View Builder"),
      ),
      body: /*DragSelectGridView(
          gridController: controller,
          padding: const EdgeInsets.all(8),
          itemCount: widgetList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: (2 / 1),
          ),
          itemBuilder: (context, index, isSelected) {
            return GestureDetector(
              onTap: () {
                //Navigator.of(context).pushNamed(RouteName.GridViewCustom);

               // isSelected = true;


                if(isSelected){
                }else{

                  isSelected = true;

                  String strisSelected = isSelected.toString();
                  Fluttertoast.showToast(
                      msg: "$strisSelected  ${widgetList[index]}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }

                selectedIndex = index;

                setState(() {});

                // if(namelist.isEmpty){
                //
                //   namelist.add(widgetList[index]);
                //
                // }else{
                //
                //   if(namelist.contains(widgetList[index])){
                //
                //     Fluttertoast.showToast(
                //         msg: "${widgetList[index]} Already Exists",
                //         toastLength: Toast.LENGTH_SHORT,
                //         gravity: ToastGravity.CENTER,
                //         timeInSecForIosWeb: 1,
                //         backgroundColor: Colors.black,
                //         textColor: Colors.white,
                //         fontSize: 16.0
                //     );
                //
                //   }else{
                //
                //     namelist.add(widgetList[index]);
                //
                //   }
                // }
                // String jsonUser = jsonEncode(namelist);
                // print(jsonUser);


              },
              child: Container(
                color: isSelected == true ? Colors.blueAccent : Colors.white,
                *//*RandomColorModel().getColor(),*//*
                margin: const EdgeInsets.all(5),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10)
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 130,
                                //top: Dimensions.size100
                              ),
                              child: Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 20,
                                // color: Theme.of(context).primarySwatch,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Center(
                              child: Image(
                                image: AssetImage(icon_black[index]),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(widgetList[index],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),*/

      SingleChildScrollView(

        child: Column(
          children: [
            // Container(
            //
            //   child: GridView.builder(
            //     itemCount: widgetList.length,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount:
            //       MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
            //       crossAxisSpacing: 8,
            //       mainAxisSpacing: 8,
            //       childAspectRatio: (2 / 1),
            //     ),
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           //Navigator.of(context).pushNamed(RouteName.GridViewCustom);
            //
            //           if(namelist.length >= 3){
            //
            //             Fluttertoast.showToast(
            //                 msg: "You Not Selected more Then Three",
            //                 toastLength: Toast.LENGTH_SHORT,
            //                 gravity: ToastGravity.CENTER,
            //                 timeInSecForIosWeb: 1,
            //                 backgroundColor: Colors.black,
            //                 textColor: Colors.white,
            //                 fontSize: 16.0
            //             );
            //
            //           }else{
            //
            //             selectedCard = index;
            //
            //             if(selectedIndex.contains(index)){
            //
            //               selectedIndex.removeAt(index);
            //
            //             }else{
            //
            //               selectedIndex.add(index);
            //             }
            //
            //             if(namelist.isEmpty){
            //               namelist.add(widgetList[index]);
            //             }else{
            //               if(namelist.contains(widgetList[index])){
            //                 namelist.removeAt(index);
            //               }else{
            //                 namelist.add(widgetList[index]);
            //               }
            //             }
            //
            //           }
            //
            //           String jsonUser = jsonEncode(namelist);
            //           print(jsonUser);
            //
            //
            //           setState(() {});
            //
            //         },
            //         child: Container(
            //           // color: selectedIndex.contains(index) ? Colors.blueAccent : Colors.white  /*RandomColorModel().getColor()*/ ,
            //           margin: const EdgeInsets.all(5),
            //           decoration: selectedIndex.contains(index) ? BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             gradient: const LinearGradient(
            //                 begin: Alignment(6.123234262925839e-17, 1),
            //                 end: Alignment(-1, 6.123234262925839e-17),
            //                 colors: [
            //                   Color.fromRGBO(31, 203, 220, 1),
            //                   Color.fromRGBO(0, 184, 202, 1)
            //                 ]),
            //
            //           ) :  BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             gradient: const LinearGradient(
            //                 begin: Alignment(6.123234262925839e-17, 1),
            //                 end: Alignment(-1, 6.123234262925839e-17),
            //                 colors: [
            //                   Color.fromRGBO(255, 255, 255, 1.0),
            //                   Color.fromRGBO(255, 255, 255, 1.0)
            //                 ]),
            //
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               Container(
            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //                 child: Column(
            //                   children: [
            //                     const Align(
            //                       alignment: Alignment.topRight,
            //                       child: Padding(
            //                         padding: EdgeInsets.only(
            //                           left: 130,
            //                           //top: Dimensions.size100
            //                         ),
            //                         child: Icon(
            //                           Icons.verified,
            //                           color: Colors.white,
            //                           size: 20,
            //                           // color: Theme.of(context).primarySwatch,
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 30,
            //                       height: 30,
            //                       child: Center(
            //                         child: Image(
            //                           image: AssetImage(icon_black[index]),
            //                         ),
            //                       ),
            //                     ),
            //                     const SizedBox(
            //                       height: 10,
            //                     ),
            //                     Text(widgetList[index],
            //                         style: const TextStyle(
            //                             fontSize: 15, color: Colors.black),
            //                         textAlign: TextAlign.center),
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Container(

              child: Html(data: "<a href=\"https://maps.google.com/maps/contrib/114711146138312454337\">L V Prasad Eye Institute</a>"),
            )
          ],
        )
      )

    );
  }
}
