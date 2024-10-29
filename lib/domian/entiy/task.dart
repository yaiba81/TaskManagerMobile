class Task {
  final int? id;
  final String taskIdentifier;
  final String taskType;
  final String taskName;
  final String details;
  final DateTime dateTimeCreated;
  final DateTime dateTimeDue;
  final DateTime dateTimeAssigned;

  Task({
    this.id,
    required this.taskIdentifier,
    required this.taskType,
    required this.taskName,
    required this.details,
    required this.dateTimeCreated,
    required this.dateTimeAssigned,
    required this.dateTimeDue,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json['id'],
        taskIdentifier: json['taskIdentifier'],
        taskType: json['taskType'],
        taskName: json['taskName'],
        details: json['details'],
        dateTimeCreated: json['dateTimeCreated'],
        dateTimeAssigned: json['dateTimeAssigned'],
        dateTimeDue: json['dateTimeDue'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskIdentifier': taskIdentifier,
      'taskType': taskType,
      'taskName': taskName,
      'details': details,
      'dateTimeCreated': dateTimeCreated,
      'dateTimeDue': dateTimeDue,
      'dateTimeAssigned': dateTimeAssigned,
    };
  }
}
