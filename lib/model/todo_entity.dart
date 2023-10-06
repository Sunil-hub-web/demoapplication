import 'package:floor/floor.dart';

@entity
class Todo {

  @PrimaryKey(autoGenerate: false)
  int id;
  String name;
  String mobileno;
  String choose1;
  String choose2;

  @ignore
  bool isSelect = true;

  Todo(this.id,this.name,this.mobileno,this.choose1,this.choose2);

 }