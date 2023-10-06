import 'ApiConstants.dart';
import 'UserDetails.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;


class ApiService {
  Future<List<UserDetails>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UserDetails> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
     }
    return null;
  }
}