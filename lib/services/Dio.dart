import 'package:dio/dio.dart';


class DioClient {
  final Dio _dio;

  DioClient({BaseOptions? baseOptions})
      : _dio = Dio(baseOptions ?? BaseOptions(
    baseUrl: 'http://10.0.2.2:8000',
    connectTimeout: Duration(milliseconds: 5000), // Connection timeout
    receiveTimeout: Duration(milliseconds: 3000), // Receive timeout
  ));

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow; // Rethrow the error after handling it
    }
  }

  // POST Request
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e); // Handle error
      rethrow; // Rethrow error after handling
    }
  }

  // PUT Request
  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e); // Handle error
      rethrow; // Rethrow error after handling
    }
  }

  // DELETE Request
  Future<Response> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleDioError(e); // Handle error
      rethrow; // Rethrow error after handling
    }
  }



  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception('Connection timeout');
      case DioExceptionType.receiveTimeout:
        throw Exception('Receive timeout');
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 401) {
          throw Exception('Unauthorized');
        } else {
          throw Exception('Error: ${e.response?.data}');
        }
      default:
        throw Exception('DioError: ${e.message}');
    }
  }
}
