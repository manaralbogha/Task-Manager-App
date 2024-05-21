class TodosModel {
  final List<Todo> todo;
  final int total;
  final int skip;
  final int limit;

  TodosModel(
      {required this.todo,
      required this.total,
      required this.skip,
      required this.limit});
  factory TodosModel.fromJson(Map<String, dynamic> jsonData) {
    return TodosModel(
      todo: jsonData["todos"],
      total: jsonData["total"],
      skip: jsonData["skip"],
      limit: jsonData["limit"],
    );
  }
}

class Todo {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  Todo(
      {required this.id,
      required this.todo,
      required this.completed,
      required this.userId});

  factory Todo.fromJson(Map<String, dynamic> jsonData) {
    return Todo(
      id: jsonData["id"],
      todo: jsonData["todo"],
      completed: jsonData["completed"],
      userId: jsonData["userId"],
    );
  }
}
