import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/core/data/api/api_key.dart';

import '../../exception/form_exception.dart';
import '../../exception/secure_storage_exception.dart';
import '../models/user.dart';

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

  AuthService() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('http')) {
        options.path = '$baseUrl${options.path}';
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioException exception, handler) async {
      if (exception.response?.statusCode == 403) {
        if (await _storage.containsKey(key: 'refreshToken')) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(exception.requestOptions));
          }
        }
      }
      return handler.next(exception);
    }));
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
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

  static Future<User> loadUser() async {
    final id = await loadUserId();
    final response = await api.get('$baseUrl/auth/users/$id');

    switch (response.statusCode) {
      case 200:
        final data = response.data as Map<String, dynamic>;
        return User.fromJson(data);
      case 400:
        final json = jsonDecode(response.data);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }

  static Future<int> loadUserId() async {
    final id = await _storage.read(
      key: 'userId',
    );
    if (id != null) {
      return int.parse(id);
      //return User.fromJson(jsonDecode(json));
    } else {
      throw SecureStorageNotFoundException();
    }
  }

  static Future<void> saveUserId(User user) async {
    await _storage.write(
      key: 'userId',
      value: user.id.toString(),
    );
  }

  static Future<bool> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final response =
        await api.post('/auth/refresh', data: {'refreshToken': refreshToken});

    if (response.statusCode == 201) {
      accessToken = response.data;
      return true;
    } else {
      accessToken = null;
      _storage.deleteAll();
      return false;
    }
  }

  static Future<User> register({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String surname,
  }) async {
    final response = await api.post(
      '$baseUrl/auth/register',
      data: jsonEncode(
        {
          'email': email,
          'password': password,
          'name': name,
          'surname': surname,
          'phone': phone
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        final data = response.data as Map<String, dynamic>;
        final json = data['user'] as Map<String, dynamic>;
        final User user = User.fromJson(json);

        await saveUserId(user);

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
      key: 'userId',
    );
  }

  static Future<User> login({
    required String email,
    required String password,
  }) async {
    final response = await api.post(
      '$baseUrl/auth/authentication',
      data: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        final data = response.data as Map<String, dynamic>;
        final json = data['user'] as Map<String, dynamic>;
        final User user = User.fromJson(json);

        saveUserId(user);

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

/*
@LazySingleton(as: AuthInterface)
class AuthService implements AuthInterface {
  AuthService();

  final dioClient = getIt.get<DioClient>();

  @override
  Future<Either<AuthException, Token>> register(String email, String pass, String confirmPass) async {
    try {
      final Token result =
      await dioClient.dio.post(
          YOUR_URL, body: {’email’: email, ‘pass’: pass, ‘confirmPass’: confirmPass});
      if (result.data != null) {
        return Right(result);
      } else {
        return const Left(AuthException.wrongEmailOrPass());
      } // here - I’m using API that gives me:
      // status code 200 and data: token and message: ‘ok’ when credentials are ok
      // status code 200 and data: null with the message: “email has been already taken”
      // Of course, you can have different data in response from your backend
    } on DioError catch (e, s) {
      //this is the place you can log your error e.g. in Sentry, Firebase Crashlytics, etc.
      return const Left(AuthException.serverError());
    }
  }

  @override
  Future<Either<AuthException, Token>> login(String email, String pass) async {
    try {
      final Token result =
      await dioClient.dio.post(
          YOUR_URL, body: {’email’: email, ‘pass’: pass});
      if (result.data != null) {
        return Right(result);
      } else {
        return const Left(AuthException.wrongEmailOrPass());
      }
    } on DioError catch (e, s) {
      return const Left(AuthException.serverError());
    }
  }

  @override
  Future<Either<AuthException, Unit>> logout(String idToken) async {
    try {
      final Token result =
      await dioClient.dio.post(
          YOUR_URL, body: {’idToken’: idToken});
      return right(unit);
    } on DioError catch (e) {
      return const Left(AuthException.serverError());
    }
  }

  @override
  Future<Either<AuthException, Token>> refresh(String refreshToken) async {
    try {
      final Token result =
      await dioClient.dio.post(
          YOUR_URL, body: {’refreshToken’: refreshToken});
      return Right(result);
    } on DioError catch (e, s) {
      return const Left(AuthException.serverError());
    }
  }
}*/
