import 'package:dio/dio.dart';

final class HttpResponse<T> {
  final int statusCode;
  final dynamic data;

  const HttpResponse({required this.statusCode, required this.data});
}

abstract interface class HttpClient {
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpResponse<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}

class DioHttp implements HttpClient {
  final Dio _dio;

  const DioHttp(this._dio);

  @override
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(path, queryParameters: queryParameters);

    return HttpResponse<T>(
      statusCode: response.statusCode ?? 404,
      data: response.data,
    );
  }

  @override
  Future<HttpResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return HttpResponse(
      statusCode: response.statusCode ?? 404,
      data: response.data,
    );
  }

  @override
  Future<HttpResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return HttpResponse(
      statusCode: response.statusCode ?? 404,
      data: response.data,
    );
  }

  @override
  Future<HttpResponse<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.delete(path, queryParameters: queryParameters);

    return HttpResponse(
      statusCode: response.statusCode ?? 404,
      data: response.data,
    );
  }
}
