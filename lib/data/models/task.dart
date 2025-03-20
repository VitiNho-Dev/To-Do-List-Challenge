class Task {
  final int id;
  final String title;
  final bool completed;
  final DateTime? dueDate;

  const Task({
    this.id = 0,
    required this.title,
    this.completed = false,
    this.dueDate,
  });

  Task copyWith({int? id, String? title, bool? completed, DateTime? dueDate}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      dueDate: dueDate,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['todo'] as String,
      completed: json['completed'] as bool,
    );
  }
}
