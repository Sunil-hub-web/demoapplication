
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GraidViewPage extends StatefulWidget {
  const GraidViewPage({super.key});

  @override
  State<GraidViewPage> createState() => _GraidViewPageState();
}

class _GraidViewPageState extends State<GraidViewPage> {
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
  List<bool> cardsValue = [false, false];
  int checkedIndex_s = 0;
  late bool isActive_s = false;
  late int index_s = 0;

  List<int> itemList = [];
  late List<int> selectedList;
  final List<String> _listItem = [
    "assets/images/img1.jpg",
    "assets/images/img2.jpg",
    "assets/images/img3.jpg",
    "assets/images/img4.jpg",
    "assets/images/img5.jpg",
    "assets/images/img6.jpg",
    "assets/images/img7.jpg",
    "assets/images/img2.jpg",
    "assets/images/img3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(6.123234262925839e-17, 1),
              end: Alignment(-1, 6.123234262925839e-17),
              colors: [
                Color.fromRGBO(31, 203, 220, 1),
                Color.fromRGBO(0, 184, 202, 1)
              ]),
        ),
        child:  Container(
          child: Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              //physics:NeverScrollableScrollPhysics(),
              // controller: ScrollController(
              //     keepScrollOffset: true),
              // shrinkWrap: false,
              // scrollDirection: Axis.vertical,
              children: widgetList.map((String value) {
                //print("____________value____________");
                // print("value: "+value);
                //  print("value: "+widgetList.length.toString());

                bool checked =
                    widgetList.indexOf(value) == checkedIndex_s;
                return GestureDetector(
                    onTap: () {
                      print(value + " is clicked");
                      itemList.add(widgetList.indexOf(value));
                      print(itemList.toString());

                      setState(
                            () {
                          isActive_s = true;
                          int index = widgetList.indexOf(value);
                          // print("index is " + index.toString());
                          checkedIndex_s = index;

                          // if (isActive_s) {
                          //   selectedList.add(itemList[index]);
                          //
                          // } else {
                          //   selectedList.remove(itemList[index]);
                          //
                          // }
                        },
                      );

                      //Get.toNamed(RouteHelper.getpackageBookingpage());
                    },
                    child: Container(
                      child: Card(
                        shadowColor: Colors.black26,  // Change this
                        color: checked ? Colors.white30 : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 130,
                                        //top: Dimensions.size100
                                      ),
                                      child: const Icon(
                                        Icons.verified,
                                        color: Colors.white,
                                        size: 20,
                                        // color: Theme.of(context).primarySwatch,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                child: Center(
                                  child: Image(
                                    image: checked ? AssetImage(icon_white[ widgetList.indexOf(value)])
                                        : AssetImage(icon_black[ widgetList.indexOf(value)]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                value,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: checked
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              }).toList(),
            ),
          ),
        ),
      ),
    );






     /* Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu),
        title: Text("Home"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("0")),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/one.jpg'),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.4),
                            Colors.black.withOpacity(.2),
                          ]
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Lifestyle Sale", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Center(child: Text("Shop Now", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: _listItem.map((item) => Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(item),
                                fit: BoxFit.cover
                            )
                        ),
                        child: Transform.translate(
                          offset: Offset(50, -50),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: Icon(Icons.bookmark_border, size: 15,),
                          ),
                        ),
                      ),
                    )).toList(),
                  )
              )
            ],
          ),
        ),
      ),
    );*/
  }
}
