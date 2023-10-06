import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DelightListResponse extends StatefulWidget {
  const DelightListResponse({super.key});

  @override
  State<DelightListResponse> createState() => _DelightListResponseState();
}

class _DelightListResponseState extends State<DelightListResponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View data List")),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(31, 203, 220, 1),
                Color.fromRGBO(0, 184, 202, 1)
              ]),
        ),
      ),
    );
  }
}
