class Challenge {
  final int id;
  final String name;
  final String description;
  final int targetSteps;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String updatedAt;

  Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.targetSteps,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      targetSteps: json['target_steps'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
