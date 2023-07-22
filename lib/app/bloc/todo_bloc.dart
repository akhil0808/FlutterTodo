import 'package:bloc/bloc.dart';
import 'package:flutter_todo/app/bloc/todo_event.dart';
import 'package:flutter_todo/app/bloc/todo_state.dart';
import 'package:flutter_todo/app/model/todo_model.dart';
import 'package:flutter_todo/app/vo/todo_data.dart';
import 'package:flutter_todo/domain/model/todo_domain.dart';
import '../../domain/usecase/add_todo.dart';
import '../../domain/usecase/delete_todo.dart';
import '../../domain/usecase/get_all_todo.dart';
import '../../domain/usecase/toggle_complete_todo.dart';
import '../../domain/usecase/undo_deleted.dart';
import '../../domain/usecase/update_todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodoUseCase getAllTodoUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final ToggleCompleteTodoUseCase toggleCompleteTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final UndoDeletedTodoUseCase undoDeletedTodoUseCase;
  TodoBloc(
      {required this.getAllTodoUseCase,
      required this.addTodoUseCase,
      required this.updateTodoUseCase,
      required this.toggleCompleteTodoUseCase,
      required this.deleteTodoUseCase,
      required this.undoDeletedTodoUseCase})
      : super(TodoLoadingState()) {
    on<TodoStartedEvent>(_onStarted);
    on<TodoItemAddedEvent>(_onItemAdded);
    on<TodoItemUpdatedEvent>(_onItemUpdated);
    on<TodoItemToggleCompletedEvent>(_onItemToggleCompleted);
    on<TodoItemDeletedEvent>(_onItemDeleted);
    on<TodoItemUndoDeletedEvent>(_onItemUndoDeleted);
  }

  void _onStarted(TodoStartedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var dataList = getAllTodoUseCase.execute();
      var todoVOList = dataList
          .map((e) => TodoData(
              id: e.id,
              title: e.title,
              description: e.description,
              isCompleted: e.isCompleted))
          .toList();
      emit(TodoLoadedState(TodoModel(todoList:todoVOList)));
    } catch (e) {
      emit(const TodoErrorState());
    }
  }

  void _onItemAdded(TodoItemAddedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var todoDomain = TodoDomain(event.todo.id, event.todo.title,
          event.todo.description, event.todo.isCompleted);
      addTodoUseCase.execute(todoDomain);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }

  void _onItemUpdated(TodoItemUpdatedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var todoDomain = TodoDomain(event.todo.id, event.todo.title,
          event.todo.description, event.todo.isCompleted);
      updateTodoUseCase.execute(todoDomain);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }

  void _onItemToggleCompleted(
      TodoItemToggleCompletedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var todoDomain = TodoDomain(event.todo.id, event.todo.title,
          event.todo.description, event.todo.isCompleted);
      toggleCompleteTodoUseCase.execute(todoDomain);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }

  void _onItemDeleted(TodoItemDeletedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      deleteTodoUseCase.execute(event.id);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }

  void _onItemUndoDeleted(
      TodoItemUndoDeletedEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoadingState());
    try {
      var todoDomain = TodoDomain(event.todo.id, event.todo.title,
          event.todo.description, event.todo.isCompleted);
      undoDeletedTodoUseCase.execute(todoDomain);
      add(TodoStartedEvent());
    } catch (_) {
      emit(const TodoErrorState());
    }
  }
}
