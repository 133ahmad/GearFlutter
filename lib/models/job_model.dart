class Job {
  final String id;
  final String carMake;
  final String carModel;
  final String issue;
  String status;
  Job({
    required this.id,
    required this.carMake,
    required this.carModel,
    required this.issue,
    this.status = 'Pending',
  });
}