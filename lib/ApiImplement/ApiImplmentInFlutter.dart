import 'package:demoapplication/ApiImplement/UserDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ApiService.dart';

class ApiImplmentInFlutter extends StatefulWidget {
  const ApiImplmentInFlutter({super.key});

  @override
  State<ApiImplmentInFlutter> createState() => _ApiImplmentInFlutterState();
}

class _ApiImplmentInFlutterState extends State<ApiImplmentInFlutter> {

  late List<UserDetails>? _userModel = [];

  void _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _userModel == null || _userModel!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _userModel!.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            color: Colors.green[300],
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_userModel![index].id.toString()),
                      Text(_userModel![index].username.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_userModel![index].email.toString()),
                      Text(_userModel![index].website.toString()),
                    ],
                  ),
                ],
              ),

            )
          );
        },
      ),
    );
  }
}
