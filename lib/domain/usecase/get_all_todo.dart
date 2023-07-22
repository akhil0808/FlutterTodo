import 'package:flutter_todo/domain/model/todo_domain.dart';
import 'package:flutter_todo/domain/repository/todo_repository.dart';

class GetAllTodoUseCase {
  final TodoRepository repository;
  GetAllTodoUseCase(this.repository);

  List<TodoDomain> execute() {
    return repository.getTodoList();
  }
}
