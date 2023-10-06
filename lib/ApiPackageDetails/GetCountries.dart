import 'dart:developer';
import 'package:http/http.dart' as http;

import 'CountriesResponse.dart';

class CountriesRes {
  Future<List<CountriesResponse>?> getCountries() async {
    http.Response? response;
    try {
      var url = Uri.parse("https://www.2designnerds.com/wherenx_user/public/api/business/get-countries");
      response = await http.get(url);
    //  return response;
      if (response.statusCode == 200) {
        List<CountriesResponse> model = userCountriesFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
