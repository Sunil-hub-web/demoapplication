
import 'package:demoapplication/LoginAndRegisterUsingProvider/providers/auth_provider.dart';
import 'package:demoapplication/LoginAndRegisterUsingProvider/providers/user_provider.dart';
import 'package:demoapplication/LoginAndRegisterUsingProvider/utility/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:provider/provider.dart';

import 'domain/user1.dart';

class LoginPageApi extends StatefulWidget {
  const LoginPageApi({super.key});

  @override
  State<LoginPageApi> createState() => _LoginPageApiState();
}

class _LoginPageApiState extends State<LoginPageApi> {
  final formKey = GlobalKey<FormState>();
  String _userName = "", _password = "";
  TextEditingController userNameController = TextEditingController();

  var doLogin = () {};

  @override
  Widget build(BuildContext context) {

    AuthProvider auth = Provider.of<AuthProvider>(context);

    doLogin(){

      final form = formKey.currentState;

      if(form!.validate()){

        form.save();

        final Future<Map<String,dynamic>> respose =  auth.login(_userName,_password);

        respose.then((response) {
          if (response['status']) {

            User1 user = response['user'];

            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.pushReplacementNamed(context, '/dashboard');

          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });

      }else{
        Flushbar(
          title: 'Invalid form',
          message: 'Please complete the form properly',
          duration: Duration(seconds: 10),
        ).show(context);
      }

    }
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Login ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        MaterialButton(
          padding: const EdgeInsets.all(0.0),
          child: const Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        MaterialButton(
          padding: const EdgeInsets.only(left: 0.0),
          child: const Text("Sign up", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
        ),
      ],
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text("Email"),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    autofocus: false,
                    validator: (value) =>
                        value!.isEmpty ? "please enter username" : null,
                    onSaved: (value) => _userName = value!,
                    controller: userNameController,
                    decoration:
                        buildInputDecoration('Enter Email', Icons.email),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text("Password"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? "Please enter password" : null,
                    onSaved: (value) => _password = value!,
                    decoration:
                        buildInputDecoration('Enter Password', Icons.lock),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  auth.loggedInStatus == Status.Authenticating
                      ?loading
                      : longButtons('Login',doLogin),
                  SizedBox(height: 8.0,),
                  forgotLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
