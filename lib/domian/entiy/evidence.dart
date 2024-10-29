class Evidence {
  final int? id;
  final String taskIdentifier;
  final String evidenceString;
  final String evidenceDescription;
  final DateTime dateTimeCreated;

  Evidence({
    this.id,
    required this.evidenceDescription,
    required this.taskIdentifier,
    required this.evidenceString,
    required this.dateTimeCreated,
  });

  factory Evidence.fromMap(Map<String, dynamic> json) => Evidence(
        id: json['id'],
        evidenceDescription: json['evidenceDescription'],
        taskIdentifier: json['taskIdentifier'],
        evidenceString: json['evidenceString'],
        dateTimeCreated: json['dateTimeCreated'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskIdentifier': taskIdentifier,
      'evidenceString': evidenceString,
      'evidenceDescription': evidenceDescription,
      'dateTimeCreated': dateTimeCreated,
    };
  }
}
