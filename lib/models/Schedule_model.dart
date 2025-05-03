import 'package:flutter/material.dart';
import 'package:intl/intl.dart';




 class Schedule {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String mechanicName;
  final String serviceType;
  final String status;

  Schedule({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.mechanicName,
    required this.serviceType,
    required this.status,
  });

  // ========== STATUS GETTERS ========== //
  bool get isUpcoming => date.isAfter(DateTime.now()) &&
      status != 'completed' &&
      status != 'cancelled';

  bool get isCompleted => status == 'completed';

  bool get isCancelled => status == 'cancelled';

  bool get isPending => status == 'pending';

  bool get isInProgress => status == 'in_progress';

  Color get statusColor {
    if (isCompleted) return Colors.green;
    if (isCancelled) return Colors.red;
    if (isInProgress) return Colors.orange;
    if (isPending) return Colors.blue;
    return Colors.grey;
  }

  String get statusText {
    if (isInProgress) return 'In Progress';
    return status[0].toUpperCase() + status.substring(1);
  }

  IconData get statusIcon {
    if (isCompleted) return Icons.check_circle;
    if (isCancelled) return Icons.cancel;
    if (isInProgress) return Icons.build;
    if (isPending) return Icons.schedule;
    return Icons.help_outline;
  }

  // ========== DATE/TIME GETTERS ========== //
  String get formattedDate => DateFormat('MMM dd, yyyy').format(date);

  String get formattedTime {
    try {
      final timeParts = time.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = timeParts[1];
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : hour == 0 ? 12 : hour;
      return '$displayHour:$minute $period';
    } catch (e) {
      return time;
    }
  }

  String get formattedDateTime => '$formattedDate at $formattedTime';

  String get dayOfWeek => DateFormat('EEEE').format(date);

  String get shortDayOfWeek => DateFormat('E').format(date);

  String get monthYear => DateFormat('MMMM yyyy').format(date);

  // ========== DURATION GETTERS ========== //
  Duration get timeUntilSchedule => date.difference(DateTime.now());

  String get timeRemaining {
    if (!isUpcoming) return '';

    final duration = timeUntilSchedule;
    if (duration.inDays > 0) {
      return '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'} remaining';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} ${duration.inHours == 1 ? 'hour' : 'hours'} remaining';
    }
    return 'Less than an hour remaining';
  }

  // ========== JSON CONVERSION ========== //
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      date: DateTime.parse(json['date']),
      time: json['time'] ?? '00:00',
      mechanicName: json['mechanic_name'] ?? 'Unknown Mechanic',
      serviceType: json['service_type'] ?? 'General Service',
      status: json['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'time': time,
    'mechanic_name': mechanicName,
    'service_type': serviceType,
    'status': status,
  };
}