import 'package:equatable/equatable.dart';
import 'package:flutter_todo/app/vo/todo_data.dart';

class TodoModel extends Equatable {

  const TodoModel({required this.todoList});

  final List<TodoData> todoList;

  @override
  List<Object> get props => [todoList];
}