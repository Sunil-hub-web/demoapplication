import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UserScreen.dart';


class FacebookLogin extends StatefulWidget {
  const FacebookLogin({super.key});

  @override
  State<FacebookLogin> createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: TextButton.icon(
            style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserScreen(),
                ),
              );
            },
            icon: Image.asset(
              'assets/images/facebook.png',
              height: 100,
              width: 100,
            ),
            label: Text(
              'Facebook Login',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )

    );
  }
}
