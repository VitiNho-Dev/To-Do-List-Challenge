import 'dart:developer';

import '../../utils/errors/custom_errors.dart';
import '../../utils/errors/error_messages.dart';
import '../../utils/http_client.dart';
import '../../utils/result.dart';

const String baseUrl = 'https://dummyjson.com';

class ApiClient {
  final HttpClient _http;

  const ApiClient({required HttpClient http}) : _http = http;

  Future<Result<Map<String, dynamic>>> getTasks() async {
    try {
      final response = await _http.get('$baseUrl/todos');

      if (response.statusCode == 200) {
        final data = response.data as Map;

        if (data.isEmpty) {
          return Result.error(ApiError(message: ErrorMessages.emptyResponse));
        }

        return Result.ok(data as Map<String, dynamic>);
      } else {
        log('GET /todos failed with status: ${response.statusCode}');

        return Result.error(ApiError(message: ErrorMessages.unableToGetTasks));
      }
    } on ClientHttpError catch (error, stackTrace) {
      log('ClientHttpError: ${error.toString()}', stackTrace: stackTrace);

      return Result.error(ClientHttpError(message: ErrorMessages.onServer));
    } catch (error, stackTrace) {
      log('Unexpected error: ${error.toString()}', stackTrace: stackTrace);

      return Result.error(UnexpectedError(message: ErrorMessages.unexpected));
    }
  }
}
