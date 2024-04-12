class ProjectModel {
  final String id;
  final String name;
  final ManagerModel associatedManager;
  final String status;
  final String startDate;

  ProjectModel({
    required this.id,
    required this.name,
    required this.associatedManager,
    required this.status,
    required this.startDate,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'associated_manager': associatedManager.toJson(),
      'status': status,
      'start_date': startDate,
    };
  }
}

class ManagerModel {
  final String id;
  final String name;
  final String designation;

  ManagerModel({
    required this.id,
    required this.name,
    required this.designation,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'designation': designation,
    };
  }
}