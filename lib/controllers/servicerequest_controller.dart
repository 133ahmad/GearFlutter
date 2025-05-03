import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gear/models/ServiceType_model.dart';
import 'package:gear/models/Mechanic.dart';
import 'package:gear/models/ServiceRequest_model.dart';
import 'package:intl/intl.dart';
import 'package:gear/utils/api_constants.dart';

class ServiceRequestController extends GetxController {
  // Form data
  var serviceTypeId = 0.obs;
  var mechanicId = 0.obs;
  var time = ''.obs;
  var date = DateTime.now().obs;
  var token = ''.obs;

  // Lists from API
  var serviceTypes = <ServiceType>[].obs;
  var mechanics = <Mechanic>[].obs;
  var serviceRequests = <ServiceRequest>[].obs;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Loading states
  var isLoading = false.obs;
  var isLoadingServiceTypes = false.obs;
  var isLoadingMechanics = false.obs;
  var isLoadingRequests = false.obs;

  // Initialize with token
  void initialize(String authToken) {
    token.value = authToken;
    fetchInitialData();
  }

  // Fetch all initial data
  Future<void> fetchInitialData() async {
    await Future.wait([
      fetchServiceTypes(),
      fetchMechanics(),
      fetchServiceRequests(),
    ]);
  }

  // Fetch service requests
  Future<void> fetchServiceRequests() async {
    try {
      isLoadingRequests.value = true;
      final response = await http.get(
        Uri.parse(ApiConstants.customerServiceRequests),
        headers: _buildHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        serviceRequests.assignAll(data.map((e) => ServiceRequest.fromJson(e)));
      } else {
        _handleErrorResponse(response, 'Failed to load service requests');
      }
    } catch (e) {
      _handleException(e, 'fetching service requests');
    } finally {
      isLoadingRequests.value = false;
    }
  }

  // Fetch service types
  Future<void> fetchServiceTypes() async {
    try {
      isLoadingServiceTypes.value = true;
      final response = await http.get(
        Uri.parse(ApiConstants.serviceTypes),
        headers: _buildHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        serviceTypes.assignAll(data.map((e) => ServiceType.fromJson(e)));
        if (serviceTypes.isNotEmpty) serviceTypeId.value = serviceTypes.first.id;
      } else {
        _handleErrorResponse(response, 'Failed to load service types');
      }
    } catch (e) {
      _handleException(e, 'fetching service types');
    } finally {
      isLoadingServiceTypes.value = false;
    }
  }

  // Fetch mechanics
  Future<void> fetchMechanics() async {
    try {
      isLoadingMechanics.value = true;
      final response = await http.get(
        Uri.parse(ApiConstants.mechanics),
        headers: _buildHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        mechanics.assignAll(data.map((e) => Mechanic.fromJson(e)));
        if (mechanics.isNotEmpty) mechanicId.value = mechanics.first.id;
      } else {
        _handleErrorResponse(response, 'Failed to load mechanics');
      }
    } catch (e) {
      _handleException(e, 'fetching mechanics');
    } finally {
      isLoadingMechanics.value = false;
    }
  }

  // Submit service request
  Future<bool> submitServiceRequest() async {
    if (!formKey.currentState!.validate()) return false;

    try {
      isLoading.value = true;
      final formattedDate = DateFormat('yyyy-MM-dd').format(date.value);

      final response = await http.post(
        Uri.parse(ApiConstants.customerServiceRequests),
        headers: _buildHeaders(withContentType: true),
        body: jsonEncode({
          'service_type_id': serviceTypeId.value,
          'mechanic_id': mechanicId.value,
          'time': time.value,
          'date': formattedDate,
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Service request created successfully');
        await fetchServiceRequests();
        return true;
      } else {
        _handleErrorResponse(response, 'Failed to create service request');
        return false;
      }
    } catch (e) {
      _handleException(e, 'submitting service request');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Get single service request
  Future<ServiceRequest?> getServiceRequest(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.customerServiceRequests}/$id'),
        headers: _buildHeaders(),
      );

      if (response.statusCode == 200) {
        return ServiceRequest.fromJson(jsonDecode(response.body));
      } else {
        _handleErrorResponse(response, 'Failed to load service request');
        return null;
      }
    } catch (e) {
      _handleException(e, 'fetching service request');
      return null;
    }
  }

  // Update service request
  Future<bool> updateServiceRequest(int id, Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final response = await http.put(
        Uri.parse('${ApiConstants.customerServiceRequests}/$id'),
        headers: _buildHeaders(withContentType: true),
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Service request updated successfully');
        await fetchServiceRequests();
        return true;
      } else {
        _handleErrorResponse(response, 'Failed to update service request');
        return false;
      }
    } catch (e) {
      _handleException(e, 'updating service request');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete service request
  Future<bool> deleteRequest(int requestId) async {
    try {
      isLoading.value = true;
      final response = await http.delete(
        Uri.parse('${ApiConstants.customerServiceRequests}/$requestId'),
        headers: _buildHeaders(),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Request deleted successfully');
        await fetchServiceRequests();
        return true;
      } else {
        _handleErrorResponse(response, 'Failed to delete request');
        return false;
      }
    } catch (e) {
      _handleException(e, 'deleting request');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Helper methods
  Map<String, String> _buildHeaders({bool withContentType = false}) {
    final headers = {
      'Authorization': 'Bearer ${token.value}',
    };
    if (withContentType) {
      headers['Content-Type'] = 'application/json';
    }
    return headers;
  }

  void _handleErrorResponse(http.Response response, String defaultMessage) {
    try {
      final errorData = jsonDecode(response.body);
      Get.snackbar(
        'Error',
        errorData['message'] ?? errorData['error'] ?? defaultMessage,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar('Error', defaultMessage);
    }
  }

  void _handleException(dynamic e, String operation) {
    Get.snackbar(
      'Error',
      'Something went wrong while $operation: ${e.toString()}',
      duration: const Duration(seconds: 3),
    );
  }
}