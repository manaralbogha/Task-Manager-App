part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChangeCheckCompleted extends HomeState {}

final class GetAllTodoByUserIdLoadingState extends HomeState {}

final class GetAllTodoByUserIdFailureState extends HomeState {
  final String failureMsg;

  GetAllTodoByUserIdFailureState({required this.failureMsg});
}

final class GetAllTodoByUserIdSuccessState extends HomeState {
  final TodosModel todosModel;

  GetAllTodoByUserIdSuccessState({required this.todosModel});
}

final class AddTodoLoadingState extends HomeState {}

final class AddTodoFailureState extends HomeState {
  final String failureMsg;

  AddTodoFailureState({required this.failureMsg});
}

final class AddTodoSuccessState extends HomeState {
  final Todo todo;

  AddTodoSuccessState({required this.todo});
}

final class DeleteTodoLoadingState extends HomeState {}

final class DeleteTodoFailureState extends HomeState {
  final String failureMsg;

  DeleteTodoFailureState({required this.failureMsg});
}

final class DeleteTodoSuccessState extends HomeState {
  final Todo todo;

  DeleteTodoSuccessState({required this.todo});
}
