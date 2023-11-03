import 'dart:convert';

import 'package:demoapplication/customeserach/CustomSearchData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomSearchResponse extends StatefulWidget {
  const CustomSearchResponse({super.key});

  @override
  State<CustomSearchResponse> createState() => _CustomSearchResponseState();
}

class _CustomSearchResponseState extends State<CustomSearchResponse> {
  TextEditingController textEditingController = TextEditingController();
  CustomSearchData customSearchData = CustomSearchData();
  List<Items> placelist = [];

  void getSuggestion(String inputValue) async {
    if (inputValue == "") {
      placelist = [];
    } else {
      placelist.clear();

        String kPLACES_API_KEY = "AIzaSyAiliPKjJgKhn0iAzO_5LL2crealuAu57Q";
        String baseURL = "https://www.googleapis.com/customsearch/v1?";
        String cx = "81d746240ffd64696";
        String query = '$baseURL?key=$kPLACES_API_KEY&cx=$cx&q=$inputValue';

        String request1 = "https://www.googleapis.com/customsearch/v1?"
            "key=$kPLACES_API_KEY&cx=$cx&q=$inputValue&num=10&start=1";

        String requestDemo = "https://www.googleapis.com/customsearch/v1?key=AIzaSyAiliPKjJgKhn0iAzO_5LL2crealuAu57Q&cx=81d746240ffd64696&q=python&start=1&num=10";

        var response = await http.get(Uri.parse(requestDemo));

        print(response.body.toString());

        if (response.statusCode == 200) {
          setState(() {
            customSearchData =
                CustomSearchData.fromJson(jsonDecode(response.body));
            if (customSearchData.items != null) {
              for (int i = 0; i < customSearchData.items!.length; i++) {
                placelist.add(customSearchData.items![i]);
              }
            }
          });
        } else {
          throw Exception("Faild gto load data");
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Custom Google Serach"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: "Serach places with name"),
            ),
            Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
                ),
              ),
              height: 46,
              child: ElevatedButton(
                onPressed: () async {
                  getSuggestion(textEditingController.text.toString());
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  minimumSize: Size(MediaQuery.of(context).size.width, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                child: const Text('Search',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: placelist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(placelist[index].title!),
                        subtitle: Text(placelist[index].link!),
                      );
                    }))
          ],
        ),
      ),
    );
    ;
  }
}
