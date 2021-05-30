import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/repositries/todo_repo.dart';
import 'package:todo_task/screens/home/bloc/home_event.dart';
import 'package:todo_task/screens/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(WaitingState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetTodosEvent) {
      yield WaitingState();
      final allTodos = await fetchTodos();
      yield HomeWithTodos(allTodos);
    } else if (event is AddTodoEvent) {
      await addTodo(event.todo);
      final currentTodos = state.todos;
      yield HomeWithTodos([...currentTodos,event.todo]);
    } else if (event is FinishTodoEvent) {
      await finishTodo(event.todo);
      final currentTodos = [...state.todos]..remove(event.todo);
      yield HomeWithTodos(currentTodos);
    }
  }
}
