
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:demoapplication/model/Todo_Deo.dart';
import 'package:demoapplication/model/todo_entity.dart';





part 'app_database.g.dart';

@Database(version: 1,entities: [Todo])
abstract class AppDatabase extends FloorDatabase{
  TodoDao get tododeo;
}

