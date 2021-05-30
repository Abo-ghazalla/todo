import 'package:equatable/equatable.dart';
import 'package:todo_task/models/todo.dart';

abstract class HomeEvent extends Equatable {
  final Todo todo;

  HomeEvent({this.todo});
  @override
  // TODO: implement props
  List<Object> get props => [todo];
}

class GetTodosEvent extends HomeEvent {}

class AddTodoEvent extends HomeEvent {
  final Todo todo;

  AddTodoEvent(this.todo) : super(todo: todo);
}

class FinishTodoEvent extends HomeEvent {
  final Todo todo;

  FinishTodoEvent(this.todo) : super(todo: todo);
}
