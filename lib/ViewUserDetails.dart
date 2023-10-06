import 'package:demoapplication/model/app_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AddTask.dart';
import 'model/Todo_Deo.dart';
import 'model/todo_entity.dart';

import 'package:flutter/material.dart';

class ViewUserDetails extends StatefulWidget {
  TodoDao? _todoDao;
  List<Todo> todolist = [];
  final database = $FloorAppDatabase.databaseBuilder('Todo.db').build();

  ViewUserDetails({super.key});

  @override
  State<ViewUserDetails> createState() => _ViewUserDetailsState();
}

class _ViewUserDetailsState extends State<ViewUserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View User Details"),
      ),
      body: FutureBuilder(
        future: _callTodo(),
        builder: (BuildContext context, AsyncSnapshot<TodoDao> snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.none) {
            return CircularProgressIndicator();
          } else {
            return StreamBuilder(
              stream: snapshot.data!.streamedData(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.none) {
                  return CircularProgressIndicator();
                } else {
                  if (widget.todolist.length != snapshot.data!.length) {
                    widget.todolist = snapshot.data!;
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text('No Data Found'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector  (
                        onTap: () => (openAlertBox(snapshot.data![index])

                            /*Fluttertoast.showToast(
                            msg: snapshot.data![index].id.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.greenAccent,
                            textColor: Colors.white,
                            fontSize: 16.0)*/

                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            //color: Colors.transparent,
                            //shadowColor: Colors.transparent,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  top: 10, right: 10, left: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        "User Id : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data![index].id.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Name  ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data![index].name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Mobnile No  ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data![index].mobileno,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Choose1  ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data![index].choose1,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Choose2  ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data![index].choose2,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTask,
        child: Icon(Icons.add),
      ),
    );
  }

  _openAddTask() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddTask();
    })).then((value) {
      setState(() {});
    });
  }

  void _deleteTask(int id) {
    widget._todoDao!.deleteTodo(id);
    setState(() {});
  }

  Future<TodoDao> _callTodo() async {
    AppDatabase appDatabase = await widget.database;
    widget._todoDao = appDatabase.tododeo;
    return appDatabase.tododeo;
  }

  openAlertBox(Todo todo) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "User Id :" + todo.id.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "User Name :" + todo.name.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Mobile No :" + todo.mobileno.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Choose1 :" + todo.choose1.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Choose2 :" + todo.choose2.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),

                  //  SizedBox(
                  //   height: 5.0,
                  // ),
                  //   Divider(
                  //   color: Colors.grey,
                  //   height: 4.0,
                  // ),
                  // SizedBox(
                  //   height: 5.0,
                  // ),

                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0)),
                      ),
                      child: Text(
                        "User Details",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
