import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListViewHomePage extends StatefulWidget {
  const ListViewHomePage({super.key});

  @override
  State<ListViewHomePage> createState() => _ListViewHomePageState();
}

class _ListViewHomePageState extends State<ListViewHomePage> {

  var titleList = [
  {'name' : "Success",'selected' : true},
  {'name' :  "Motivation",'selected' : true},
  {'name' : "Hard Work",'selected' : true},
  {'name' :  "Decision",'selected' : true},
  {'name' :  "Confidence",'selected' : true},
  {'name' :   "Team Work",'selected' : true},
  {'name' :   "Team Work",'selected' : true}, ];

  // Description List Here
  var descList = [
    "Push yourself, because no one else is going to do it for you.",
    "Your limitation—it's only your imagination.",
    "Hard Work changes the life.",
    "Sometimes it's the smallest decisions that can change your life forever.",
    "Confidence is the most beautiful thing you can possess",
    "A big business starts small.",
    "Talent wins games, but teamwork and intelligence win championships."
  ];

  // Image Name List Here
  var imgList = [
    "assets/images/img-1.png",
    "assets/images/img-2.png",
    "assets/images/img-3.png",
    "assets/images/img-4.png",
    "assets/images/img-5.png",
    "assets/images/img-1.png",
    "assets/images/img-2.png"
  ];

   int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List View Click Event",
          style: TextStyle(color: Colors.pink),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: imgList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {

                selectedIndex = index;

                if( titleList[index]['selected'] == false){

                  titleList[index]['selected'] = true;

                }else{

                  titleList[index]['selected'] = false;
                }

                Fluttertoast.showToast(
                    msg: titleList[index]['name'].toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);

                setState(() {});
                // showDialogFunc(context,imgList[index],titleList[index],descList[index]);
              },

              child: /*Container(
                decoration: selectedIndex == index ? const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment(6.123234262925839e-17, 1),
                      end: Alignment(-1, 6.123234262925839e-17),
                      colors: [
                        Color.fromRGBO(255, 255, 255, 1.0),
                        Color.fromRGBO(255, 255, 255, 1.0)
                      ]),
                ) : const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
              begin: Alignment(6.123234262925839e-17, 1),
                end: Alignment(-1, 6.123234262925839e-17),
                colors: [
                  Color.fromRGBO(255, 255, 255, 1),
                  Color.fromRGBO(255, 255, 255, 1)
                ]),
            ),
                child:*/
                  Card(
                      elevation: 5,
                      child: Container(
                        decoration: titleList[index]['selected'] == false ? const BoxDecoration(
                      color: Colors.greenAccent,
                    ) : const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              child: Image.asset(imgList[index]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    titleList[index]['name'].toString(),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width,
                                    child: Text(
                                      descList[index],
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[500]),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
              //),
            );
          }),
    );
  }

  showDialogFunc(BuildContext context, imgList, titleList, descList) {
    return showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.cyan),
              height: 320.0,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      imgList,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    titleList,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    descList,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
