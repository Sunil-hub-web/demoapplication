import 'model/NearByplaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/geopoint.dart';

class NearcyLocationApi {
  static NearcyLocationApi _instance = NearcyLocationApi._();
  String kGoogleApiKey = 'AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k';

  NearcyLocationApi._();

  static NearcyLocationApi get instance {
    if (_instance == null) {
      _instance = NearcyLocationApi._();
    }
    return _instance;
  }

  Future<List<Results>> getNearby({required GeoPoint userLocation, required double radius, required String type, required String keyword}) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${userLocation.latitude},${userLocation.longitude}&radius=$radius&type=$type&keyword=$keyword&key=${kGoogleApiKey}');
   // http.Response response = await http.get(url);
    var response = await http.get(url);
    final values = jsonDecode(response.body);
    final List result = values['results'];
    print(result);
    return result.map((e) => Results.fromJson(e)).toList();
  }
}