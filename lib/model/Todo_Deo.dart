import 'package:demoapplication/model/todo_entity.dart';
import 'package:floor/floor.dart';



@dao
abstract class TodoDao{

  @Query("SELECT * from Todo")
  Future<List<Todo>> findAllTodo();
  
  @Query("SELECT * from Todo order by id desc limit 1")
  Future<Todo?> getMaxId();

  @Query("SELECT * from Todo order by id desc")
  Stream<List<Todo>> streamedData();

  @insert
  Future<void> insertTodo(Todo todo);

  @update
  Future<void> updateTodo(Todo todo);
  
  @Query("delete from Todo where id = :id")
  Future<void> deleteTodo(int id);

  @Query('SELECT * FROM Todo WHERE mobileno = :mobileno')
  Future<Todo?> findUserById(int mobileno);

  @delete
  Future<int> deleteAll(List<Todo> list);

}