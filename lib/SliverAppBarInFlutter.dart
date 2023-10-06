import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverAppBarInFlutter extends StatelessWidget {
  const SliverAppBarInFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    List images = [
      "star-icon.png",
      "direction-s.png",
      "Pin-s.png",
    ];
    List item1 = ["4.1", "5.5 km", "526 pins"];
    List item2 = ["59 Reviews", "Directions", "Pins this"];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 50,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(Icons.clear), Icon(Icons.add_shopping_cart)],
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              // leading: Icon(Icons.menu),
              // title: Text("SliverAppBar"),
              expandedHeight: 300,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/food-image.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                /*Container(
                color: Colors.pink,
              ),*/
                // title: Text("Sliver App Bar"),
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: SingleChildScrollView(

            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFF8F8F8),
              ),

              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 50),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text( "Burger Palace",
                              style:TextStyle(
                                color: Color(0xFF212828),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: 32,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 0, right: 0,)),
                                ),
                                onPressed: () {},
                                child: Row (
                                  children: const <Widget>[
                                    Image(image: AssetImage("assets/images/share-g.png"), width: 18, ),
                                    SizedBox(width: 5,),
                                    Text("Share",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFA1A8A9),
                                          fontWeight: FontWeight.normal),
                                    ), // text
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        const Text(
                          "Restaurant - close at 10pm",
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    // color: Colors.blueGrey[50],
                    transform: Matrix4.translationValues(0.0, -35.0, 0.0),
                    child: Center(
                      child: Wrap(
                        children: List<Widget>.generate(3,(index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Container(
                                    child: Material(
                                      color: Theme.of(context).cardColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(50),
                                            bottomLeft: Radius.circular(50),
                                            topLeft: Radius.circular(50),
                                            topRight: Radius.circular(50)),
                                      ),
                                      elevation: 4,
                                      shadowColor: Colors.black38,
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        height: 60,
                                        width: 60,
                                        child: Image.asset("assets/images/" + images[index],
                                          width: 10,
                                          height: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Column(
                                    children: [
                                      Text(item1[index],
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(item2[index],
                                        style: const TextStyle(
                                            color: Colors.black38,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // child: GestureDetector(
                            //   onTap: (){
                            //
                            //   },
                            //   child: Container(
                            //     margin: EdgeInsets.all(5),
                            //     child: CircleAvatar(
                            //       backgroundColor: Colors.white,
                            //       radius: 25,
                            //       backgroundImage: AssetImage(
                            //           "assets/images/"+images[index],
                            //
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          );
                        },
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text("About",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut facilisis nulla, non aliquam libero. Nunc pretium massa nec massa consectetur, vel ullamcorper ",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 12
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),

        //   slivers: [

        /*  SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  color: Colors.deepPurple[400],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  color: Colors.deepPurple[400],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  color: Colors.deepPurple[400],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  color: Colors.deepPurple[400],
                ),
              ),
            ),
          ),*/

        //  ],
      ),
    );
  }
}
