import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ConvertLatLongToAddress extends StatefulWidget {
  const ConvertLatLongToAddress({super.key});

  @override
  State<ConvertLatLongToAddress> createState() => _ConvertLatLongToAddressState();
}

class _ConvertLatLongToAddressState extends State<ConvertLatLongToAddress> {
  TextEditingController textEditingController = TextEditingController();

  var uuid = Uuid();
  String _sessionToken = "122344";
  List<dynamic> placelist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    textEditingController.addListener(() { onChange();});
  }

  void onChange(){

    if(_sessionToken == null){
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(textEditingController.text);

   // setState(() {});
  }

  void getSuggestion(String inputValue) async{

    if(inputValue == ""){

      placelist = [];

    }else{

      String kPLACES_API_KEY = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";
      String baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request = '$baseURL?input=$inputValue&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

      String request1 = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputValue&types=geocode&key=$kPLACES_API_KEY";

      var response = await http.get(Uri.parse(request1));

      print(response.body.toString());

      if(response.statusCode == 200){

        setState(() {

          placelist = jsonDecode(response.body.toString()) ['predictions'];

        });

      }else{

        throw Exception("Faild gto load data");
      }
    }



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Google Serach Places Api"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: "Serach places with name"
              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: placelist.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: () async {
                      List<Location> locations = await locationFromAddress(placelist[index]['description']);
                      
                      print(locations.last.latitude);
                      print(locations.last.longitude);

                    },
                    title: Text(placelist[index]['description']),
                  );

                }
            )
            )
          ],
        ),
      ),
    );
  }
}
