import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/repositries/todo_repo.dart';
import 'package:todo_task/screens/home/bloc/home_bloc.dart';
import 'package:todo_task/screens/home/bloc/home_event.dart';
import 'package:todo_task/screens/home/bloc/home_state.dart';
import 'package:todo_task/screens/home/widgets/add_todo_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<ConnectivityResult> subscription;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: BlocProvider<HomeBloc>(
        create: (_) {
          return HomeBloc()..add(GetTodosEvent());
        },
        child: Builder(
          builder: (ctx) => BlocBuilder<HomeBloc, HomeState>(
            builder: (_, state) {
              if (state is WaitingState)
                return Center(child: CircularProgressIndicator());
              return Column(
                children: [
                  Expanded(
                    child: state.todos.isEmpty
                        ? Center(child: Text("NO TODOS ADDED YET!"))
                        : ListView.builder(
                            itemBuilder: (_, i) => ListTile(
                              key: ValueKey(state.todos[i].id),
                              title: Text("${i + 1} - ${state.todos[i].title}"),
                              trailing: FlatButton(
                                child: Text("Finish"),
                                color: Colors.green,
                                onPressed: () {
                                  BlocProvider.of<HomeBloc>(ctx)
                                      .add(FinishTodoEvent(state.todos[i]));
                                },
                              ),
                            ),
                            itemCount: state.todos.length,
                          ),
                  ),
                  RaisedButton(
                    child: Text("Add Todo"),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => AddTodoForm(
                                bloc: BlocProvider.of<HomeBloc>(ctx),
                              ));
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        whenReconnect();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
