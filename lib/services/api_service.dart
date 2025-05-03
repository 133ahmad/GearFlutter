import 'package:dio/dio.dart' as dio_package;
import 'package:get/get.dart';

class ApiService extends GetxService {
  late final dio_package.Dio _dio;

  @override
  Future<void> onInit() async {
    super.onInit();
    _initializeDio();
  }

  void _initializeDio() {
    _dio = dio_package.Dio(dio_package.BaseOptions(
      baseUrl: '',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

    _dio.interceptors.add(dio_package.LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<dio_package.Response> get(String path, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParams,
        options: dio_package.Options(headers: headers),
      );
    } on dio_package.DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<dio_package.Response> post(String path, Map<String, Object> map, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: dio_package.Options(headers: headers),
      );
    } on dio_package.DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<dio_package.Response> delete(String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParams,
        options: dio_package.Options(headers: headers),
      );
    } on dio_package.DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(dio_package.DioException e) {
    String errorMessage = 'An error occurred';

    if (e.response != null) {
      errorMessage = e.response?.data['message'] ??
          e.response?.statusMessage ??
          'Server error occurred';
    } else {
      switch (e.type) {
        case dio_package.DioExceptionType.connectionTimeout:
          errorMessage = 'Connection timeout';
          break;
        case dio_package.DioExceptionType.receiveTimeout:
          errorMessage = 'Receive timeout';
          break;
        case dio_package.DioExceptionType.connectionError:
          errorMessage = 'No internet connection';
          break;
        default:
          errorMessage = e.message ?? 'Unknown error occurred';
      }
    }

    Get.snackbar('Error', errorMessage);
  }
}