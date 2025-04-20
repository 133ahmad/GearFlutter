import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:gear/models/PartModel.dart';

class OrdersController extends GetxController {
  var isLoading = false.obs;
  var parts = <PartModel>[].obs;
  TextEditingController searchController = TextEditingController();

  Future<void> searchParts(String query) async {
    try {
      isLoading(true);
      var response = await Dio().get('http://127.0.0.1:8000/api/car-parts', queryParameters: {
        'search': query,
      });

      if (response.statusCode == 200) {
        parts.value = (response.data as List).map((e) => PartModel.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch parts');
    } finally {
      isLoading(false);
    }
  }
}
