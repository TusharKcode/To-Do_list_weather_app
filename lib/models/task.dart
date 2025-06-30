class Task {
  int? id;                  // Unique ID (nullable for new tasks)
  String title;             // Task title
  String description;       // Task description
  bool isHighPriority;      // Flag for high priority

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isHighPriority = false,
  });

  // Convert Task to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isHighPriority': isHighPriority ? 1 : 0,
    };
  }

  // Create Task from Map (database)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isHighPriority: map['isHighPriority'] == 1,
    );
  }
}
