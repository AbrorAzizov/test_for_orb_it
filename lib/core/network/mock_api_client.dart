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
    return Response(requestOptions: RequestOptions(path: path), statusCode: 200);
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
    return Response(requestOptions: RequestOptions(path: path), statusCode: 200);
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
