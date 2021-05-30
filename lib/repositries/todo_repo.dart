import 'package:connectivity/connectivity.dart';
import 'package:todo_task/models/todo.dart';
import 'package:todo_task/services/api_service.dart';
import 'package:todo_task/services/local_storage.dart';
import 'package:hive/hive.dart';


Future<List<Todo>> fetchTodos() async {
  final dbHelper = DbHelper.instance;
  var savedTodos = await dbHelper.queryAllRows();
  if (savedTodos.isEmpty) {
    return await fetchFromFirebase();
  }
  return List<Todo>.from(
      savedTodos.map((savedPost) => Todo.fromMap(savedPost)));
}

Future<void> addTodo(Todo todo) async {
  final dbHelper = DbHelper.instance;
  await dbHelper.insert({"id": todo.id, "title": todo.title});
  _updateOnServer();
}

Future<void> finishTodo(Todo todo) async {
  final dbHelper = DbHelper.instance;
  await dbHelper.delete(todo.id);
  _updateOnServer();
}

Future<void> _updateOnServer() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    await Hive.box("memory").put("needToSync", true);
  } else {
    final dbHelper = DbHelper.instance;
    var savedTodos = await dbHelper.queryAllRows();
    updateUserTodos(savedTodos);
  }
}

Future<void> whenReconnect() async {
  bool needToSync = Hive.box("memory").get("needToSync") ?? false;
  if (needToSync) {
    final dbHelper = DbHelper.instance;
    var savedTodos = await dbHelper.queryAllRows();
    await updateUserTodos(savedTodos);
    Hive.box("memory").put("needToSync", false);
  }
}
