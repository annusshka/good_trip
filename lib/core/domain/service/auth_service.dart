import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../exception/form_exception.dart';
import '../../exception/secure_storage_exception.dart';
import '../models/user.dart';
import 'secure_storage_service.dart';


/*
class Api {
  final Dio api = Dio();
  String? accessToken;

  final _storage = const FlutterSecureStorage();

  Api() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('http')) {
        options.path = 'http://localhost:8080${options.path}';
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if ((error.response?.statusCode == 401 &&
          error.response?.data['message'] == "Invalid JWT")) {
        if (await _storage.containsKey(key: 'refreshToken')) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final response = await api
        .post('/auth/refresh', data: {'refreshToken': refreshToken});

    if (response.statusCode == 201) {
      accessToken = response.data;
      return true;
    } else {
      // refresh token is wrong
      accessToken = null;
      _storage.deleteAll();
      return false;
    }
  }
}
*/
class AuthService {
  static final Dio api = Dio();

  static String? accessToken;

  static const _storage = FlutterSecureStorage();

  static Future<User> loadUser() async {
    final json = await _storage.read(
      key: SecureStorageService.userKey,
    );
    if (json != null) {
      return User.fromJson(jsonDecode(json));
    } else {
      throw SecureStorageNotFoundException();
    }
  }

  static void saveUser(User user) async {
    await _storage.write(
      key: SecureStorageService.userKey,
      value: user.toString(),
    );
  }

  static Future<bool> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final response = await api
        .post('/auth/refresh', data: {'refreshToken': refreshToken});

    if (response.statusCode == 201) {
      accessToken = response.data;
      return true;
    } else {
      // refresh token is wrong
      accessToken = null;
      _storage.deleteAll();
      return false;
    }
  }

  static Future<User> register({
    required String email,
    required String password,
    required String cellphone,
    required String firstName,
    required String lastName,
  }) async {
    final response = await api.post('token/',
      data: jsonEncode(
        {
          'email': email,
          'password': password,
          'cellphone': cellphone,
          'first_name': firstName,
          'last_name': lastName
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.data);
        final user = User.fromJson(json);

        saveUser(user);

        return user;
      case 400:
        final json = jsonDecode(response.data);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<void> logout() async {
    await _storage.delete(
      key: SecureStorageService.userKey,
    );
  }

  static Future<User> login({
    required String email,
    required String password,
  }) async {
    final response = await api.post('token/',
      data: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.data);
        final user = User.fromJson(json);

        saveUser(user);

        return user;
      case 400:
        final json = jsonDecode(response.data);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }
}