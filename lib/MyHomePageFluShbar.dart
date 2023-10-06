import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Flutter Snackbar Example - using Flushbar library",style: TextStyle(fontSize: 18,color: Colors.black,fontStyle: FontStyle.italic,decoration: TextDecoration.none),textAlign: TextAlign.center,),
            ),
            MaterialButton(
              child: Text("Simple",style: TextStyle(color: Colors.white),),
              color: Colors.orange,
              onPressed: (){
                show_Simple_Flushbar(context);
              },
            ),
            MaterialButton(
              child: Text("Text With Message n Icon",style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                show_Title_n_message_Flushbar(context);
              },
            ),
            MaterialButton(
              child: Text("Flush Bar Helper",style: TextStyle(color: Colors.white),),
              color: Colors.green,
              onPressed: (){
                show_FlushbarHelper(context);
              },
            ),
            MaterialButton(
              child: Text("Customized Flush bar",style: TextStyle(color: Colors.white),),
              color: Colors.green,
              onPressed: (){
                show_Custom_Flushbar(context);
              },
            ),
            MaterialButton(
              child: Text("Customized1 Flush bar",style: TextStyle(color: Colors.white),),
              color: Colors.green,
              onPressed: (){
                show_Customized_Flushbar(context);
              },
            ),

            MaterialButton(
              child: Text("Simple Flush bar",style: TextStyle(color: Colors.white),),
              color: Colors.blueAccent,
              onPressed: (){
                background_color_Flushbar(context);
              },
            ),

            MaterialButton(
              child: Text("Left indicator bar",style: TextStyle(color: Colors.white),),
              color: Colors.blueAccent,
              onPressed: (){
                right_indicator_bar_Flushbar(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  //Simple Flushbar with a button
  void show_Simple_Flushbar(BuildContext context) {
    Flushbar(
      // There is also a messageText property for when you want to
      // use a Text widget and not just a simple String
      message: 'Hello from a Flushbar',
      // Even the button can be styled to your heart's content
      mainButton: MaterialButton(
        child: const Text(
          'Click Me',
          style: TextStyle(color: Colors.green),
        ),
        onPressed: () {},
      ),
      duration: Duration(seconds: 3),
      // Show it with a cascading operator
    ).show(context);
  }
  void show_Title_n_message_Flushbar(BuildContext context) {
    Flushbar(
      title: 'Success',
      message: 'Form Submitted successfully',
      icon: Icon(
        Icons.done_outline,
        size: 28,
        color: Colors.green.shade300,
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 3),
    )..show(context);
  }
  void show_FlushbarHelper(BuildContext context) {
    FlushbarHelper.createInformation(
      title: 'Exit',
      message: 'Do you want to close the app ?',
    ).show(context);
  }
  void show_Custom_Flushbar(BuildContext context) {
    Flushbar(
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8),
      backgroundGradient: LinearGradient(
        colors: [Colors.green.shade800, Colors.greenAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'This is a customized Snackar',
      message: 'Try it now ',
    )..show(context);
  }

  void show_Simple_Flushbar1(BuildContext context){

    Flushbar(
      title:  "Hey Ninja",
      message:  "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      duration:  Duration(seconds: 3),
    )..show(context);
  }

  void show_Customized_Flushbar(BuildContext context){

    Flushbar(
      title: "Hey Ninja",
      titleColor: Colors.white,
      message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue[300]!, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      backgroundGradient: const LinearGradient(colors: [Colors.blueGrey, Colors.black]),
      isDismissible: false,
      duration: const Duration(seconds: 4),
      icon: Icon(
        Icons.check,
        color: Colors.greenAccent,
      ),
      mainButton: MaterialButton(
        onPressed: () {},
        child: Text(
          "CLAP",
          style: TextStyle(color: Colors.amber),
        ),
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.blueGrey,
      titleText: Text(
        "Hello Hero",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily: "ShadowsIntoLightTwo"),
      ),
      messageText: Text(
        "You killed that giant monster in the city. Congratulations!",
        style: TextStyle(fontSize: 18.0, color: Colors.green, fontFamily: "ShadowsIntoLightTwo"),
      ),
    )..show(context);
  }

  void show_Simple_Flushbar2(BuildContext context){

    Flushbar(
      message:  "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      duration:  Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: Icon(Icons.info_outline),
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(10),
      // flushbarStyle: FlushbarStyle.FLOATING,
    )..show(context);
  }

  void Left_indicator_bar_Flushbar(BuildContext context){

    Flushbar(
      message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue[300],
    )..show(context);
  }

  void right_indicator_bar_Flushbar(BuildContext context){

    Flushbar(
      message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      margin: EdgeInsets.all(6.0),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      textDirection: Directionality.of(context),
      borderRadius: BorderRadius.circular(12),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue[300],
    ).show(context);
  }

  void background_color_Flushbar(BuildContext context){

    Flushbar(
      title: "Hey Ninja",
      message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
      backgroundColor: Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue[800]!, offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
    )..show(context);
  }
}