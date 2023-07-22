import 'package:flutter_todo/domain/model/todo_domain.dart';
import 'package:flutter_todo/domain/repository/todo_repository.dart';

class UndoDeletedTodoUseCase {
  final TodoRepository repository;
  UndoDeletedTodoUseCase(this.repository);

  void execute(TodoDomain todoDomain) {
    return repository.addTodo(todoDomain);
  }
}
