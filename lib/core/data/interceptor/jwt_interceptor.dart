import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/models/exception/auth_error.dart';

class JwtInterceptor extends Interceptor {
  JwtInterceptor({
    required Dio dio,
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  })  : _dio = dio,
        _storage = storage;

  final Dio _dio;

  final FlutterSecureStorage _storage;

  Future<String?> readUserJwt() async {
    return _storage.read(key: 'jwt');
  }

  Future<String?> readRefreshJwt() async {
    return _storage.read(key: 'refresh_jwt');
  }

  Future<bool> hasJwt() async {
    return await _storage.containsKey(key: 'jwt');
  }

  Future<bool> hasRefreshJwt() async {
    return await _storage.containsKey(key: 'refresh_jwt');
  }

  Future<void> saveUserJwt(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  Future<void> saveUserJwtR(String token) async {
    await _storage.write(key: 'refresh_jwt', value: token);
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = await _storage.read(key: 'refreshToken');
      final response = await _dio
          .post('$baseUrl/auth/refresh', data: {'refreshToken': refreshToken});
      if (response.statusCode == 200 || response.statusCode == 201) {
        await saveUserJwt(response.data.jwt);
        await saveUserJwtR(response.data.refreshJwt);
        return true;
      } else {
        return false;
      }
    } on DioException catch (error) {
      throw AuthError(
        name: 'RefreshTokenError',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    }
  }

  @override
  FutureOr<dynamic> onRequest(RequestOptions options, handler) async {
    if (!options.path.contains('http')) {
      options.baseUrl = baseUrl;
      options.path = '$baseUrl${options.path}';
    }
    final jwt = await readUserJwt();
    if (jwt != null && jwt.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $jwt';
    }
    return handler.next(options);
  }

  @override
  Future<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    if (response != null && response.statusCode == 401) {
      String? jwt;
      if (await hasRefreshJwt()) {
        jwt = await readRefreshJwt();
      }

      if (jwt != null && jwt.isNotEmpty) {
        if (await refreshToken()) {
          final jwt = await readUserJwt();
          err.requestOptions.headers['Authorization'] = 'Bearer $jwt';
          return handler.resolve(await _retry(err.requestOptions));
        } else {
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(
      requestOptions.baseUrl + requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
