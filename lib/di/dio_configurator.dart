import 'package:dio/dio.dart';
import 'package:dio_interceptor_plus/dio_interceptor_plus.dart';
import 'package:good_trip/core/data/api/api_key.dart';

Dio configDio(
    {Iterable<Interceptor>? additionalInterceptors,}) {
  const timeout = Duration(seconds: 30);

  final dio = Dio();

  dio.options
    ..baseUrl = baseUrl
    ..connectTimeout = timeout
    ..receiveTimeout = timeout
    ..sendTimeout = timeout;

  if (additionalInterceptors != null) {
    dio.interceptors.addAll(additionalInterceptors);
  }

  dio.interceptors.add(LoggingInterceptor());

  return dio;
}
