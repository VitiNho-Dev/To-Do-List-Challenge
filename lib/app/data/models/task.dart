class Task {
  final int id;
  final String title;
  final bool completed;

  const Task({required this.id, required this.title, required this.completed});

  Task copyWith({int? id, String? title, bool? completed}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  static Map<String, dynamic> toJson(Task task) {
    return {'title': task.title, 'completed': task.completed};
  }
}
