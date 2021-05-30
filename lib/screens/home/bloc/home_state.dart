import 'package:equatable/equatable.dart';
import 'package:todo_task/models/todo.dart';

abstract class HomeState extends Equatable {
  final List<Todo> todos;

  HomeState({this.todos});
  @override
  // TODO: implement props
  List<Object> get props => [todos];
}

class WaitingState extends HomeState {}

class HomeWithTodos extends HomeState {
  final List<Todo> todos;

  HomeWithTodos(this.todos) : super(todos: todos);
}
