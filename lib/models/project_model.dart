class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String status;
  final DateTime dueDate;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.dueDate,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      dueDate: DateTime.parse(json['dueDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}