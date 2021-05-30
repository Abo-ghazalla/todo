import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_task/models/todo.dart';

Future<List<Todo>> fetchFromFirebase() async {
  try {
    final todoSnapshot = await FirebaseFirestore.instance
        .collection("all_todos")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    final allTodos =
        List<Map<String, dynamic>>.from(todoSnapshot.data()["todos"]);
    return allTodos.map((item) => Todo.fromMap(item));
  } catch (e) {
    return [];
  }
}

Future<void> updateUserTodos(List<Map<String, dynamic>> todos) async {
  await FirebaseFirestore.instance
      .collection("all_todos")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .set({"todos": todos});
}
