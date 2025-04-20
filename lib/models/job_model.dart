class Job {
  final int id;
  final String carMake;
  final String carModel;
  final String issue;
  final String status;
  final String? description;
  final String? plateNumber;

  Job({
    required this.id,
    required this.carMake,
    required this.carModel,
    required this.issue,
    required this.status,
    this.description,
    this.plateNumber,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      carMake: json['car_make'] ?? json['carMake'] ?? '',
      carModel: json['car_model'] ?? json['carModel'] ?? '',
      issue: json['issue'] ?? '',
      status: json['status'] ?? 'Pending',
      description: json['description'],
      plateNumber: json['plate_number'] ?? json['plateNumber'],
    );
  }

  Job copyWith({
    int? id,
    String? carMake,
    String? carModel,
    String? issue,
    String? status,
    String? description,
    String? plateNumber,
  }) {
    return Job(
      id: id ?? this.id,
      carMake: carMake ?? this.carMake,
      carModel: carModel ?? this.carModel,
      issue: issue ?? this.issue,
      status: status ?? this.status,
      description: description ?? this.description,
      plateNumber: plateNumber ?? this.plateNumber,
    );
  }
}