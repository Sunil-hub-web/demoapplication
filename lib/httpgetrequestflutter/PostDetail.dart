import 'package:demoapplication/httpgetrequestflutter/HttpService1.dart';
import 'package:flutter/material.dart';
import 'HttpService.dart';
import 'Post.dart';

class PostDetail extends StatelessWidget {
  final Post post;
  final HttpService1 httpService = HttpService1();

  PostDetail({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(post.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: const Text("Title"),
                        subtitle: Text(post.title),
                      ),
                      ListTile(
                        title: const Text("ID"),
                        subtitle: Text("${post.id}"),
                      ),
                      ListTile(
                        title: const Text("Body"),
                        subtitle: Text(post.body),
                      ),
                      ListTile(
                        title: const Text("User ID"),
                        subtitle: Text("${post.userId}"),
                      ),

                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await httpService.deletePost(post.id);
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}