class Task {
  Task({required this.id, required this.title, required this.done});

  String id;
  String title;
  bool done;

  Map toJsonEncodable() {
    final map = {};
    map['id'] = id;
    map['title'] = title;
    map['done'] = done;
    return map;
  }
}
