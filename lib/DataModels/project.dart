class Projects {
  final String id;
  final String name;
  final String status;
  final String date;



  Projects({
    required this.id,
    required this.name,
    required this.status,
    required this.date,
  });

  factory Projects.fromJson(Map<String, dynamic> json) {
    return Projects(
      id: json['_id'],
      name: json['name'],
      status: json['status'],
      date: json['start_date'],
    );
  }
}