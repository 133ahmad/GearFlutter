import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gear/models/job_model.dart';
import 'package:gear/models/mechanic.dart';

class MechanicService {
  final String apiUrl = 'http://127.0.0.1:8000/api/';

  Future<Mechanic> getMechanicProfile(int mechanicId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/mechanics/$mechanicId'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data == null) throw Exception('No data received');
      return Mechanic.fromJson(data);
    } else {
      throw Exception('Failed to load mechanic profile: ${response.statusCode}');
    }
  }

  Future<List<Job>> getAssignedJobs(int mechanicId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/mechanics/$mechanicId/jobs'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Job.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load assigned jobs: ${response.statusCode}');
    }
  }

  Future<Mechanic> updateAvailability(int mechanicId, String availability) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/mechanics/$mechanicId/availability'),
      headers: _headers(),
      body: jsonEncode({'availability': availability}),
    );

    if (response.statusCode == 200) {
      return Mechanic.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update availability: ${response.statusCode}');
    }
  }

  Future<void> updateJobStatus(int jobId, String newStatus) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/jobs/$jobId/status'),
      headers: _headers(),
      body: jsonEncode({'status': newStatus}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update job status: ${response.statusCode}');
    }
  }

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Add authorization if needed
      // 'Authorization': 'Bearer $token',
    };
  }
}