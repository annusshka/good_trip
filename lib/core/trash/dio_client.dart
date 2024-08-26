// import 'package:dio/dio.dart';
// import 'package:dio_interceptor_plus/dio_interceptor_plus.dart';
// import 'package:good_trip/core/data/api/api_key.dart';
// import 'package:injectable/injectable.dart';
//
// @Singleton()
// class DioClient {
//   late final Dio _dio = Dio();
//
//   DioClient() {
//     _dio.options = BaseOptions(
//       baseUrl: baseUrl,
//       receiveTimeout: const Duration(seconds: 100),
//       connectTimeout: const Duration(seconds: 100),
//       sendTimeout: const Duration(seconds: 100),
//     );
//
//     _dio.interceptors.add(LoggingInterceptor());
//   }
//
//   Dio get apiDio => _dio;
// }