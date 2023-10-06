import 'package:demoapplication/ViewUserDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/Todo_Deo.dart';
import 'model/app_database.dart';
import 'model/todo_entity.dart';

class LoginPage extends StatefulWidget {

  TodoDao? _todoDao;
  List<Todo> todolist = [];
  List<String> todolist1 = [];
  final database = $FloorAppDatabase.databaseBuilder('Todo.db').build();

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController mobileNoController = TextEditingController();
  List images = [
    "google.png",
    "facebook.png",
    "twitter.png",
  ];
  int length = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(6.123234262925839e-17, 1),
                end: Alignment(-1, 6.123234262925839e-17),
                colors: [
                  Color.fromRGBO(31, 203, 220, 1),
                  Color.fromRGBO(0, 184, 202, 1),
                ]),
          ),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                'assets/images/logo_w.png',
                              ),
                            ),
                            Container(
                                child: Text(
                                  "WhereNX",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.normal),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Form(
                        key: formGlobalKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    cursorColor: const Color(0xFFA1A8A9),
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    controller: mobileNoController,
                                    style: TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                      contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      labelText: "Phone number or Email address",
                                      labelStyle: TextStyle(
                                        color: Color(0xFFDDE4E4),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.person_outline_rounded,
                                        color: Colors.grey,
                                      ),
                                      floatingLabelStyle:
                                      TextStyle(color: Color(0xFFA1A8A9)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFDDE4E4),
                                            width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFA1A8A9),
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                    validator:  (value){
                                      if (value == null || value.isEmpty) {
                                        return 'Field can not be empyty';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (value == null || value.isEmpty) {
                                        return;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
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
                                        //Get.toNamed(RouteHelper.getotpScreenpage());
                                        if (formGlobalKey.currentState!.validate()) {
                                          formGlobalKey.currentState?.save();

                                          AppDatabase appDatabase = await widget.database;
                                          widget._todoDao = appDatabase.tododeo;

                                          widget.todolist =  await widget._todoDao!.findAllTodo();

                                          if(widget.todolist != null){

                                            for(int i = 0;i<widget.todolist.length;i++){

                                              if(widget.todolist[i].mobileno == mobileNoController.text.toString()){

                                                String todolist2 = widget.todolist[i].mobileno;
                                                widget.todolist1.add(todolist2);
                                              };
                                            }

                                            if(widget.todolist1.contains(mobileNoController.text.toString())){

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (context) => ViewUserDetails()));

                                            }else{

                                              Fluttertoast.showToast(
                                                  msg: "Mobile No Not Found ?",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                            }

                                          }else{

                                            Fluttertoast.showToast(
                                                msg: "Data Not Found ?",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }

                                          // use the email provided here
                                        }else{

                                          Fluttertoast.showToast(
                                              msg: "Register Success Data Added",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }


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
                                      child: const Text('Sign up',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 15)),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:const EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.25,
                                            height: 0.5,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).dividerColor,
                                                //color:Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              width: MediaQuery.of(context).size.width * 0.25,
                                              child: const Text(
                                                'or sign in with',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 12),
                                              )),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.25,
                                            height: 0.5,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).dividerColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Wrap(
                                    children: List<Widget>.generate(
                                      length,
                                          (index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              child: Material(
                                                color: Theme.of(context).cardColor,
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                      bottomRight:
                                                      Radius.circular(50),
                                                      bottomLeft: Radius.circular(50),
                                                      topLeft: Radius.circular(50),
                                                      topRight: Radius.circular(50)),
                                                ),
                                                elevation: 1,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    child: Image(
                                                      image: AssetImage( "assets/images/" + images[index],),
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                  /* ElevatedButton(
                                      onPressed: () {
                                        if (formGlobalKey.currentState!.validate()) {
                                          //valid flow
                                        }
                                      },

                                      child: Text("Submit"),
                                  ),
*/
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF8F8F8),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Center(
                                            child: Text(
                                              'Don’t have an account?',
                                              style: TextStyle(color: Colors.blueGrey),
                                            )),
                                        Container(
                                          padding: const EdgeInsets.only(bottom: 20, top: 10, left: 20, right: 20),
                                          width: MediaQuery.of(context).size.width,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12.0),
                                                    side: const BorderSide(color: Color(0xFF00B8CA),),
                                                  )
                                              ),
                                            ),
                                            onPressed: () {
                                              // Get.toNamed(RouteHelper.getSignInScreen());
                                            },
                                            child: const Text('Sign in',
                                                style: TextStyle(
                                                    height: 1.4,
                                                    color: Colors.cyan,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
