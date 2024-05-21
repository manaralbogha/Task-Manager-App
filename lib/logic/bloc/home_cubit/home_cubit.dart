import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_app/domain/models/todo_model/todo_model.dart';
import 'package:task_manager_app/logic/repositories/home/home_repo.dart';
import 'package:task_manager_app/ui/helpers/cache_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  final formKey = GlobalKey<FormState>();
  final todoController = TextEditingController();

  List<Todo> todo = [];

  bool checkCompleted = false;

  void changeCheckCompleted() {
    checkCompleted = !checkCompleted;
    emit(ChangeCheckCompleted());
  }

  Future getAllTodoByUserId() async {
    emit(GetAllTodoByUserIdLoadingState());
    (await homeRepo.getAllTodoByUserId()).fold(
      (failure) => emit(
        GetAllTodoByUserIdFailureState(failureMsg: failure.errorMsg),
      ),
      (todoModel) => emit(
        GetAllTodoByUserIdSuccessState(todosModel: todoModel),
      ),
    );
  }

  Future addTodo({
    required String todo,
    required bool completed,
    required int userId,
  }) async {
    emit(AddTodoLoadingState());
    (await homeRepo.addTodo(
      todo: todo,
      completed: completed,
      userId: userId,
    ))
        .fold(
            (failure) => emit(
                  AddTodoFailureState(failureMsg: failure.errorMsg),
                ), (todo) {
      Random random = Random();
      int randomNumber = random.nextInt(10000);
      this.todo.add(todo);
      Map<String, dynamic> map = {
        'id': randomNumber,
        'todo': todo.todo,
        'completed': todo.completed,
        'userId': todo.userId,
      };

      List<String> todoLocal = CacheHelper.getStringList(key: "todo") ?? [];

      String todoString = json.encode(map);

      todoLocal.add(todoString);

      CacheHelper.setStringList(key: "todo", list: todoLocal);

      emit(
        AddTodoSuccessState(todo: todo),
      );
    });
  }

  Future deleteTodo({required int todoId}) async {
    emit(DeleteTodoLoadingState());
    (await homeRepo.deleteTodo(todoId: todoId)).fold(
        (failure) => emit(
              DeleteTodoFailureState(failureMsg: failure.errorMsg),
            ), (todo) {
      this.todo.removeWhere((item) => item.id == todoId);
      emit(
        DeleteTodoSuccessState(todo: todo),
      );
    });
  }
}
