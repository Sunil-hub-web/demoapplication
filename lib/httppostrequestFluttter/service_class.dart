import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:demoapplication/httppostrequestFluttter/signup_model.dart';
import 'package:http/http.dart' as http;


Future<http.Response?> register(SignUpBody data) async {
  http.Response? response;
  try {
    response =
    await http.post(
        Uri.parse("http://127.0.0.1:8000/api/v1/auth/register"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}