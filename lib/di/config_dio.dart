import 'package:dio/dio.dart';
import 'package:dio_interceptor_plus/dio_interceptor_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/interceptor/jwt_interceptor.dart';

Dio configDio() {
  const timeout = Duration(minutes: 3);

  final dio = Dio();

  dio.options
    ..baseUrl = baseUrl
    ..contentType = Headers.jsonContentType
    ..connectTimeout = timeout
    ..receiveTimeout = timeout
    ..sendTimeout = timeout;

  dio.interceptors.add(LoggingInterceptor());

  final jwtInterceptor = JwtInterceptor(
    dio: dio,
    storage: const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  );

  dio.interceptors.add(jwtInterceptor);

  return dio;
}
