import 'dart:convert';

import 'package:demoapplication/MyHomePageFluShbar.dart';
import 'package:demoapplication/httppostrequestFluttter/ShowResponse.dart';
import 'package:demoapplication/httppostrequestFluttter/service_class.dart';
import 'package:demoapplication/httppostrequestFluttter/signup_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';

import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    void show_FlushbarHelper(String statusCode) {
      FlushbarHelper.createInformation(
        title: statusCode,
        message: 'Do you want to close the app ?',
      ).show(context);
    }

    Future<http.Response> createUser(String name, String job) {
      return http.post(
        Uri.parse('https://reqres.in/api/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'name': name, 'job': job}),
      );
    }

    Future<List<ShowResponse>> _registration() async {
      String name = nameController.text.trim().toString();
      String phone = phoneController.text.trim().toString();

      http.Response response = await createUser(name, phone);
      //List<ShowResponse> showdata = userModelDataFromJson(response.body);
      var jsonResponse = json.decode(response.body);
      var objRoot = ShowResponse.fromJson(jsonResponse);
      // var products = showdata.map((obj) => ShowResponse.fromJson(obj)).toList();
      print(response.body);
      List<ShowResponse> datalist = [];
      datalist.add(objRoot);
      show_FlushbarHelper(objRoot.name!);

      // This will be sent as form data in the post requst
      //
      // var map = new Map<String, dynamic>();

      // map['username'] = 'username';
      // map['password'] = 'password';
      //
      // final response = await http.post(
      //   Uri.parse('http/url/of/your/api'),
      //   body: map,
      // );

      print(response.body);

      return datalist;
    }

    // Future<void> _registration() async {
    //
    //   String name = nameController.text.trim();
    //   String phone = phoneController.text.trim();
    //   String email = emailController.text.trim();
    //   String password = passwordController.text.trim();
    //
    //   SignUpBody signUpBody = SignUpBody(
    //       name: name, phone: phone, email: email, password: password);
    //
    //   http.Response? response = await register(signUpBody);
    //   print(response.body);
    //
    //   show_FlushbarHelper(response.statusCode);
    //
    //   if (response.statusCode == 200) {
    //
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) =>  MyHomePage()),
    //     );
    //   }
    //
    //   /*var provider = Provider.of<DataClass>(context, listen: false);
    //   await provider.postData(signUpBody);
    //   if (provider.isBack) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) =>  MyHomePage()),
    //     );
    //   }*/
    // }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 100),
              //app logo
              Container(
                  height: 100,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 80,
                    ),
                  )),
              //your email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //your password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password_sharp),
                  hintText: "Password",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //your name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Name",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //your phone
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                    hintText: "Phone", prefixIcon: Icon(Icons.phone)),
              ),
              SizedBox(
                height: 20 + 20,
              ),
              //sign up button
              GestureDetector(
                onTap: () {
                  _registration();

                  //show_FlushbarHelper(200);
                },
                child: Container(
                  height: 70,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 23),
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF74beef),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //tag line
              RichText(
                  text: TextSpan(
                      text: "Have an account already?",
                      style: TextStyle(color: Colors.grey[500], fontSize: 20))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //sign up options
              RichText(
                  text: TextSpan(
                      text: "Sign up using one of the following methods",
                      style: TextStyle(color: Colors.grey[500], fontSize: 16))),
            ],
          ),
        ));
  }
}
