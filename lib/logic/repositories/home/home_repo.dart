import 'package:dartz/dartz.dart';
import 'package:task_manager_app/domain/models/todo_model/todo_model.dart';
import 'package:task_manager_app/logic/core/error/failures.dart';

abstract class HomeRepo {
  Future<Either<Failure, TodosModel>> getAllTodoByUserId();
  Future<Either<Failure, Todo>> addTodo({
    required String todo,
    required bool completed,
    required int userId,
  });
  Future<Either<Failure, Todo>> deleteTodo({required int todoId});
}
