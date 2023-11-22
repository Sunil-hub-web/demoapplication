import 'dart:convert';

import 'package:http/http.dart' as http;

class ViewVideoReview{

  Future<http.Response?> viewVideoReview(String userId, String placeId) async {

    http.Response? response;

    try{

    //  http.Response response;

      response = await http.post(Uri.parse("https://www.profileace.com/wherenx_user/public/api/business/view-user-video-reviews"),
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String,String>{
            'user_id': userId,
            'place_id': placeId
          })
      );

    }catch(e){
      print("errormessage${e.toString()}");
    }

   return response;

  }
}