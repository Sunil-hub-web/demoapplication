
import 'package:demoapplication/ViewUserDetails.dart';
import 'package:demoapplication/model/app_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ApiPackageDetails/CountriesResponse.dart';
import 'ApiPackageDetails/GetCountries.dart';
import 'model/Todo_Deo.dart';
import 'model/todo_entity.dart';
import 'dart:math';

class RegisterPage extends StatefulWidget {

  TodoDao? _todoDao;
  List<Todo> todolist = [];
  final database = $FloorAppDatabase.databaseBuilder('Todo.db').build();

  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
 /* final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];*/
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "USA11", child: Text("USA")),
      const DropdownMenuItem(value: "Canada11", child: Text("Canada")),
      const DropdownMenuItem(value: "Brazil11", child: Text("Brazil")),
      const DropdownMenuItem(value: "England11", child: Text("England")),
    ];
    return menuItems;
  }
 // Object selectedValue;

  final list = ["Apple", "Orange", "Kiwi", "Banana", "Grape"];
  List<DropdownMenuItem<String>> _createList() {
    return list
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
        value: e,
        child: Text(e),
      ),
    ).toList();
  }

  late List<CountriesResponse>? _userModel = [];
  List<String> countriesRes = [];
  void _getData() async {
    _userModel = (await CountriesRes().getCountries())!;
    print(_userModel.toString());
    for(int i= 0;i < _userModel!.length;i++){
      countriesRes.add(_userModel![i].name!);
    }
    print(countriesRes.toString());
     Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }


  String? selectedValue = null,selectedValue1 = null;

  late int id = 0,val = 10;
  Random random = Random();
  Random random2 = Random.secure();

  List images = [
    "google.png",
    "facebook.png",
    "twitter.png",
  ];
  int length = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
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
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
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
                                    controller: fullNameController,
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      labelText: "FullName",
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
                                    validator: (value) {
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
                                  TextFormField(
                                    cursorColor: const Color(0xFFA1A8A9),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: mobileNoController,
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      labelText: "FullName",
                                      labelStyle: TextStyle(
                                        color: Color(0xFFDDE4E4),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.phone_android_outlined,
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
                                    validator: (value) {
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
                                  DropdownButtonFormField(
                                    hint: Text("Choose an item"),
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      labelText: "FullName",
                                      labelStyle: TextStyle(
                                        color: Color(0xFFDDE4E4),
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
                                      fillColor: Colors.white,
                                    ),
                                    value: selectedValue,

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Select Your Country';
                                      } else {
                                        return null;
                                      }
                                    },
                                    dropdownColor: Colors.white,

                                    items: countriesRes.map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),

                                    /*items: list.
                                    map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      );
                                    }).toList(),*/

                                    onChanged: (value) {
                                      setState(() {

                                        selectedValue = value.toString();

                                        Fluttertoast.showToast(
                                            msg: selectedValue!,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );

                                        if (value == null || value.isEmpty) {
                                          return;
                                        } else {
                                          return null;
                                        }

                                      });
                                    },

                                  ),
                                  DropdownButtonFormField(
                                    hint: Text("Choose an item"),
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      labelText: "FullName",
                                      labelStyle: TextStyle(
                                        color: Color(0xFFDDE4E4),
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
                                    validator: (value) => value == null
                                        ? "Select a country"
                                        : null,
                                    dropdownColor: Colors.white54,
                                    value: selectedValue1,

                                    items: countriesRes.map((String item) {
                                      return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        );
                                    }
                                    ).toList(),

                                    // items: <String>['Dog', 'Cat', 'Tiger', 'Lion'].map<DropdownMenuItem<String>>((String value) {
                                    //   return DropdownMenuItem<String>(
                                    //     value: value,
                                    //     child: Text(
                                    //       value,
                                    //       style: TextStyle(fontSize: 20),
                                    //     ),
                                    //   );
                                    // }).toList(),
                                    onChanged: (Object? value) {
                                      setState(() {
                                        selectedValue1 = (value ?? "") as String?;
                                      });
                                    },

                                  ),
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

                                          var min = 1;
                                          var max = 50;
                                          id = min + random.nextInt(max - min);

                                          final employee = Todo(
                                              id,fullNameController.text.toString(),mobileNoController.text.toString(),
                                              selectedValue!,selectedValue1!);

                                          await widget._todoDao!.insertTodo(employee);

                                          Fluttertoast.showToast(
                                              msg: "Register Success",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );

                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => ViewUserDetails()));
                                          // // use the email provided here
                                        }else{

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
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20,),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'By signing up, you agree to our',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 12),
                                            ),
                                            TextSpan(
                                              text: ' Terms of Service',
                                              style: TextStyle(
                                                  color: Colors.cyan, fontSize: 12),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  debugPrint('The button is clicked!');
                                                },
                                            ),
                                            TextSpan(
                                              text: '\nand ',
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 12),
                                            ),
                                            TextSpan(
                                              text: 'Privacy Policy.',
                                              style: TextStyle(
                                                  color: Colors.cyan, fontSize: 12),
                                              recognizer: TapGestureRecognizer()..onTap = () => print('Tap Here onTap'),
                                             /* recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  print('Tap Here onTap')
                                                },*/
                                            ),
                                          ],
                                        ),
                                      )),
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
              )),
        ),
      ),
    );
  }
  Future<TodoDao> _callTodo() async{

    AppDatabase appDatabase = await widget.database;
    widget._todoDao = appDatabase.tododeo;
    return appDatabase.tododeo;

  }

  _save() {
    final database = $FloorAppDatabase.databaseBuilder('todo.db').build();

    database.then((value) {
      value.tododeo.getMaxId().then((val) {
        int id = 1;
        if (val != null) {
          id = val.id + 1;
        }
        value.tododeo.insertTodo(Todo(
            id,
            fullNameController as String,mobileNoController as String,selectedValue1!,selectedValue!));
      });
    });
    Navigator.pop(context);
  }
}


