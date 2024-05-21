import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_manager_app/domain/models/todo_model/todo_model.dart';
import 'package:task_manager_app/domain/remote/dio_helper.dart';
import 'package:task_manager_app/domain/remote/end_points.dart';
import 'package:task_manager_app/logic/core/error/failures.dart';
import 'package:task_manager_app/logic/repositories/home/home_repo.dart';
import 'package:task_manager_app/ui/helpers/cache_helper.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Future<Either<Failure, TodosModel>> getAllTodoByUserId() async {
    try {
      var userId = await CacheHelper.getData(key: "userId");
      var response = await DioHelper.getData(
        url: "${EndPoints.getAllTodoByUserId}/$userId",
      );

      List<Todo> todo = [];

      for (var item in response.data["todos"]) {
        todo.add(Todo.fromJson(item));
      }
      TodosModel todosModel = TodosModel(
        todo: todo,
        limit: response.data["limit"],
        total: response.data["total"],
        skip: response.data["skip"],
      );

      return right(todosModel);
    } catch (ex) {
      log('There is an error in login method in HomeRepoImpl');

      if (ex is DioException) {
        if (ex.response?.statusCode == 401 || ex.response?.statusCode == 400) {
          log(ex.response?.data['message']);
          return left(
            Failure(
              errorMsg: ex.response?.data['message'] ??
                  'Something Went Wrong, Please Try Again',
            ),
          );
        }
      }

      return left(Failure(errorMsg: 'Something Went Wrong, Please Try Again'));
    }
  }

  @override
  Future<Either<Failure, Todo>> addTodo({
    required String todo,
    required bool completed,
    required int userId,
  }) async {
    try {
      var response = await DioHelper.postData(url: EndPoints.addTodo, body: {
        "todo": todo,
        "completed": completed,
        "userId": userId,
      });

      return right(Todo.fromJson(response.data));
    } catch (ex) {
      log('There is an error in login method in HomeRepoImpl');

      if (ex is DioException) {
        if (ex.response?.statusCode == 401 || ex.response?.statusCode == 400) {
          log(ex.response?.data['message']);
          return left(
            Failure(
              errorMsg: ex.response?.data['message'] ??
                  'Something Went Wrong, Please Try Again',
            ),
          );
        }
      }

      return left(Failure(errorMsg: 'Something Went Wrong, Please Try Again'));
    }
  }

  @override
  Future<Either<Failure, Todo>> deleteTodo({required int todoId}) async {
    try {
      var response =
          await DioHelper.deleteData(url: "${EndPoints.deleteTodo}/$todoId");
      return right(Todo.fromJson(response.data));
    } catch (ex) {
      log('There is an error in login method in HomeRepoImpl');

      if (ex is DioException) {
        if (ex.response?.statusCode == 401 || ex.response?.statusCode == 400) {
          log(ex.response?.data['message']);
          return left(
            Failure(
              errorMsg: ex.response?.data['message'] ??
                  'Something Went Wrong, Please Try Again',
            ),
          );
        }
      }

      return left(Failure(errorMsg: 'Something Went Wrong, Please Try Again'));
    }
  }
}
