import 'dart:convert';

import 'package:http/http.dart' as http;

class ViewSingleEventList{

   Future<http.Response> viewSingleEventList(eventID) async{

    http.Response response;

    response = await http.post(Uri.parse("https://www.profileace.com/wherenx_user/public/api/business/business-event-show"),

      headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8',},

      body: jsonEncode(<String,String>{"id":eventID}));

    return response;

  }
}