import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'Post.dart';

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> getPosts() async {
    var url = Uri.parse(postsURL);
    http.Response res = await http.get(url);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body.map((dynamic item) => Post.fromJson(item),).toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  // Future<void> deletePost(int id) async {
  //   http.Response res = await delete("$postsURL/$id") as http.Response;
  //
  //   if (res.statusCode == 200) {
  //     print("DELETED");
  //   } else {
  //     throw "Unable to delete post.";
  //   }
  // }
}