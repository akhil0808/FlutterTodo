import 'package:equatable/equatable.dart';
import 'package:flutter_todo/app/vo/todo_data.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodoStartedEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class TodoItemAddedEvent extends TodoEvent {
  const TodoItemAddedEvent(this.todo);

  final TodoData todo;

  @override
  List<Object?> get props => [todo];
}

class TodoItemUpdatedEvent extends TodoEvent {
  const TodoItemUpdatedEvent(this.todo);

  final TodoData todo;

  @override
  List<Object?> get props => [todo];
}

class TodoItemToggleCompletedEvent extends TodoEvent {
  const TodoItemToggleCompletedEvent(this.todo);

  final TodoData todo;

  @override
  List<Object?> get props => [todo];
}

class TodoItemDeletedEvent extends TodoEvent {
  const TodoItemDeletedEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [];
}

class TodoItemUndoDeletedEvent extends TodoEvent {
  const TodoItemUndoDeletedEvent(this.todo);

  final TodoData todo;

  @override
  List<Object?> get props => [];
}
