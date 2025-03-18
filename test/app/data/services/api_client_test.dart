import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list_app/data/services/api_client.dart';
import 'package:todo_list_app/utils/errors/custom_errors.dart';
import 'package:todo_list_app/utils/errors/error_messages.dart';
import 'package:todo_list_app/utils/http_client.dart';
import 'package:todo_list_app/utils/result.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late ApiClient apiClient;

  setUp(() {
    httpClient = HttpClientMock();
    apiClient = ApiClient(httpClient: httpClient);
  });

  void mockHttpClientResponse({
    required int statusCode,
    required dynamic data,
  }) {
    when(
      () => httpClient.get(any()),
    ).thenAnswer((_) async => HttpResponse(data: data, statusCode: statusCode));
  }

  void mockHttpClientError(Exception exception) {
    when(() => httpClient.get(any())).thenThrow(exception);
  }

  group('ApiClient', () {
    test('should return a Map when the request is successful', () async {
      mockHttpClientResponse(
        statusCode: 200,
        data: {
          "todos": [
            {"id": 1, "title": "Task 1", "completed": false},
          ],
        },
      );

      final result = await apiClient.getTasks();

      expect(result, isA<Ok<Map<String, dynamic>>>());
      final data = (result as Ok<Map<String, dynamic>>).value;
      expect(data['todos'], isNotEmpty);

      verify(() => httpClient.get('$baseUrl/todos')).called(1);
    });

    test('should return an error when response is empty', () async {
      mockHttpClientResponse(statusCode: 200, data: {});

      final result = await apiClient.getTasks();

      expect(result, isA<Error>());
      final error = (result as Error).error as ApiError;
      expect(error.message, ErrorMessages.emptyResponse);

      verify(() => httpClient.get('$baseUrl/todos')).called(1);
    });

    test('should return an error when unable to get tasks', () async {
      mockHttpClientResponse(statusCode: 500, data: '');

      final result = await apiClient.getTasks();

      expect(result, isA<Error>());
      final error = (result as Error).error as ApiError;
      expect(error.message, ErrorMessages.unableToGetTasks);

      verify(() => httpClient.get('$baseUrl/todos')).called(1);
    });

    test('should return an error when a ClientHttpError occurs', () async {
      mockHttpClientError(ClientHttpError(message: ErrorMessages.onServer));

      final result = await apiClient.getTasks();

      expect(result, isA<Error>());
      final error = (result as Error).error as ClientHttpError;
      expect(error.message, ErrorMessages.onServer);

      verify(() => httpClient.get('$baseUrl/todos')).called(1);
    });

    test('should return an error when an unexpected error occurs', () async {
      mockHttpClientError(UnexpectedError(message: ErrorMessages.unexpected));

      final result = await apiClient.getTasks();

      expect(result, isA<Error>());
      final error = (result as Error).error as UnexpectedError;
      expect(error.message, ErrorMessages.unexpected);

      verify(() => httpClient.get('$baseUrl/todos')).called(1);
    });
  });
}
