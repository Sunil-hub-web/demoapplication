import 'package:demoapplication/ViewListinDioMVVM/ApiService.dart';
import 'package:demoapplication/ViewListinDioMVVM/UserData.dart';
import 'package:demoapplication/ViewListinDioMVVM/UserRepository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UserViewModel.dart';

class UserListConsumer extends StatefulWidget {
  const UserListConsumer({super.key}); // A stateful widget to display the users

  @override
  State<UserListConsumer> createState() => _UserListConsumerState(); // Returns the state of the widget
}

class _UserListConsumerState extends State<UserListConsumer> {

  List<UserData> userdata = [];

  getData() async {
    var dio = Dio();
    var res = await dio.get('https://jsonplaceholder.typicode.com/users',
        options: Options(
          responseType: ResponseType.plain,
        ));

    if(res.statusCode == 200){

      print("Connection successful");
      print(res.data);
      userdata.add(res.data);
      //encoded response:
      //{error: false, msg: Hello World, data: [Hari, Krishna, John]}

      //Non encoded plain response:
      //{"error":false,"msg":"Hello World","data":["Hari","Krishna","John"]}
    }else{
      print("Error while connecting to server.");
    }
  }

  @override
  void initState() { // Called when the state object is inserted into the tree.
    super.initState();

    //final userViewModel = Provider.of<UserViewModel>(context, listen: false); // Fetches userViewModel object
   // userViewModel.fetchUsers(); // Calls the method to fetch the users

    getData();

  }

  @override
  Widget build(BuildContext context) { // Build method which returns the UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (context, index) {
          final user = userdata[index];
          return ListTile(
            title: Text(user.name!),
            subtitle: Text(user.email!),
            leading: CircleAvatar(
              child: Text(user.id.toString()),
            ),
          );
        },
      ) /*Consumer<UserViewModel>( // Consumer widget to listen for changes in UserViewModel
        builder: (context, userViewModel, child) {
          if (userViewModel.loading) { // If data is still loading, show a progress indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userViewModel.errorMessage.isNotEmpty) { // If there is an error, show the error message
            return Center(
              child: Text(userViewModel.errorMessage),
            );
          } else { // Otherwise, show the list of users
            return ListView.builder(
              itemCount: userdata.length,
              itemBuilder: (context, index) {
                final user = userdata[index];
                return ListTile(
                  title: Text(user.name!),
                  subtitle: Text(user.email!),
                  leading: CircleAvatar(
                    child: Text(user.id.toString()),
                  ),
                );
              },
            );
          }
        },
      ),*/
    );
  }
}