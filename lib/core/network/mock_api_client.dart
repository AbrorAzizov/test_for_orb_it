import 'package:dio/dio.dart';
import 'api_client.dart';

class MockApiClient implements ApiClient {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    dynamic data;

    if (path == '/user/me') {
      data = {
        'id': '1',
        'email': 'test@example.com',
        'name': 'John Doe',
        'photoUrl': 'https://api.dicebear.com/7.x/avataaars/svg?seed=John',
      };
    } else if (path == '/businesses') {
      data = [
        {
          'id': 'b1',
          'name': 'Coffee Shop',
          'description': 'Best coffee in town',
          'imageUrl': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93',
        },
        {
          'id': 'b2',
          'name': 'Tech Solutions',
          'description': 'Software development services',
          'imageUrl': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
        },
      ];
    }

    return Response(
      data: data as T,
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    dynamic responseData;

    if (path == '/login') {
      final email = data['email'];
      final password = data['password'];
      if (email == 'test@example.com' && password == 'password') {
        responseData = {
          'id': '1',
          'email': 'test@example.com',
          'name': 'Test User',
          'photoUrl': 'https://api.dicebear.com/7.x/avataaars/svg?seed=Test',
        };
      } else {
        return Response(
          requestOptions: RequestOptions(path: path),
          statusCode: 401,
          statusMessage: 'Unauthorized',
        );
      }
    } else if (path == '/login/google') {
      responseData = {
        'id': '2',
        'email': 'google_user@gmail.com',
        'name': 'Google User',
        'photoUrl': 'https://api.dicebear.com/7.x/avataaars/svg?seed=Google',
      };
    }

    return Response(
      data: responseData as T,
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Response(requestOptions: RequestOptions(path: path), statusCode: 200);
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Response(requestOptions: RequestOptions(path: path), statusCode: 200);
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Response(requestOptions: RequestOptions(path: path), statusCode: 200);
  }

  @override
  Future<Response<T>> upload<T>(
    String path, {
    required FormData data,
    void Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Response(requestOptions: RequestOptions(path: path), statusCode: 200);
  }
}
