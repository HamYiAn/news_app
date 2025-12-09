import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../constants/api_constants.dart';

class ApiService extends GetxService {
  late Dio _dio;

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['apiKey'] = ApiConstants.apiKey;
          return handler.next(options);
        },
      ),
    );
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return 'Connection timeout. Please check your internet connection.';
    } else if (error.type == DioExceptionType.badResponse) {
      if (error.response?.statusCode == 401) {
        return 'Unauthorized. Please check your API key.';
      } else if (error.response?.statusCode == 429) {
        return 'Too many requests. Please try again later.';
      } else if (error.response?.statusCode == 500) {
        return 'Server error. Please try again later.';
      }
      return 'Server error: ${error.response?.statusCode}';
    } else if (error.type == DioExceptionType.unknown) {
      return 'No internet connection. Please check your network.';
    }
    return 'Something went wrong. Please try again.';
  }
}
