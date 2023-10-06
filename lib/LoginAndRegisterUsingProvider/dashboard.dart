import 'package:demoapplication/LoginAndRegisterUsingProvider/providers/user_provider.dart';
import 'package:demoapplication/LoginAndRegisterUsingProvider/utility/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/user1.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("DASHBOARD PAGE"),
        elevation: 0.1,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(child: Text('${user.email}')),
          const SizedBox(height: 100),
          MaterialButton(
            onPressed: () {
              UserPreferences().removeUser();
              Navigator.pushReplacementNamed(context, '/login');
            },
            color: Colors.lightBlueAccent,
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}
