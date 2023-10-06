import 'dart:convert';
import 'package:http/http.dart';

class HttpService1 {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  // ...

  Future deletePost(int id) async {
    var url = Uri.parse("$postsURL/$id");
    Response res = await delete(url);

    if (res.statusCode == 200) {
      print("Deleted");
    } else {
      throw "Sorry! Unable to delete this post.";
    }
  }
}