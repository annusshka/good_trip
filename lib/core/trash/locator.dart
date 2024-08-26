// import 'package:dio/dio.dart';
// import 'package:dio_interceptor_plus/dio_interceptor_plus.dart';
// import 'package:get_it/get_it.dart';
// import 'package:good_trip/core/data/service/service.dart';
// import 'package:good_trip/core/domain/dio_client.dart';
//
// import '../data/interceptor/jwt_interceptor.dart';
//
// final locator = GetIt.instance;
//
// void setupLocator() {
//   // locator.registerSingleton(
//   //     Dio()..interceptors.addAll([JwtInterceptors(), LoggingInterceptor()]),
//   //     instanceName: 'dio');
//   locator.registerSingleton(
//       Dio()..interceptors.addAll([LoggingInterceptor()]),
//       instanceName: 'dio');
//   locator.registerLazySingleton<AuthService>(
//           () => AuthService(wrapper: JwtInterceptor()));
//   locator.registerLazySingleton<TourService>(() => TourService());
//   locator.registerLazySingleton<WeatherService>(() => WeatherService());
// }
