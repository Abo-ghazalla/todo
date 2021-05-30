import 'package:flutter/material.dart';
import 'package:todo_task/models/todo.dart';
import 'package:todo_task/screens/home/bloc/home_bloc.dart';
import 'package:todo_task/screens/home/bloc/home_event.dart';

class AddTodoForm extends StatelessWidget {

  final HomeBloc bloc;

  const AddTodoForm({ this.bloc});
  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController(text: "");
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter a todo"),
          ),
          const SizedBox(height: 5),
          FlatButton(
            color: Colors.blue,
            child: Text("ADD"),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                bloc.add(AddTodoEvent(
                  Todo(
                    id: DateTime.now().toString(),
                    title: _controller.text,
                  ),
                ));
                _controller.clear();
              }
            },
          ),
          const SizedBox(height: 15),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
