import 'package:demoapplication/model/todo_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/app_database.dart';

class AddTask extends StatefulWidget {
  final TextEditingController _textEditingController = TextEditingController();

  AddTask({Key? key, this.id, this.task}) : super(key: key);
  final int? id;
  final String? task;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool idIsNull = true;
  @override
  void initState() {
    if (widget.id != null) {
      widget._textEditingController.text = widget.task!;
      idIsNull = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: idIsNull ? Text('Add Task') : Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: [
          TextField(
            controller: widget._textEditingController,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              idIsNull ? _save() : _saveEdit();
            },
            child: Text('Save'),
          ),
        ]),
      ),
    );
  }

  _save() {
    final database = $FloorAppDatabase.databaseBuilder('todo.db').build();

    database.then((value) {
      value.tododeo.getMaxId().then((val) {
        int id = 1;
        if (val != null) {
          id = val.id + 1;
        }
        value.tododeo.insertTodo(Todo(
            id,
            widget._textEditingController.value.text,
            DateFormat('dd-mm-yyyy kk:mm').format(DateTime.now()),
            "",""));
      });
    });
    Navigator.pop(context);
  }

  _saveEdit() {
    final database = $FloorAppDatabase.databaseBuilder('todo.db').build();

    database.then((value) {
      value.tododeo.updateTodo(Todo(
          widget.id!,
          widget._textEditingController.value.text,
          DateFormat('dd-mm-yyyy kk:mm').format(DateTime.now()),
          "",""));
    });
    Navigator.pop(context);
  }
}