class Todo {
  Todo({
    this.id,
    this.title,
  });

  String id;
  String title;

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
        id: map["id"],
        title: map["title"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
      };
}
