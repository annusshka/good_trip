// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:dio_interceptor_plus/dio_interceptor_plus.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:good_trip/core/data/api/api_key.dart';
// import 'package:good_trip/core/data/locator.dart';
//
// import '../../../exception/form_exception.dart';
// import '../../../exception/secure_storage_exception.dart';
// import '../../models/user/user.dart';
//
// /*
// class Api {
//   final Dio api = Dio();
//   String? accessToken;
//
//   final _storage = const FlutterSecureStorage();
//
//   Api() {
//     api.interceptors
//         .add(InterceptorsWrapper(onRequest: (options, handler) async {
//       if (!options.path.contains('http')) {
//         options.path = 'http://localhost:8080${options.path}';
//       }
//       options.headers['Authorization'] = 'Bearer $accessToken';
//       return handler.next(options);
//     }, onError: (DioError error, handler) async {
//       if ((error.response?.statusCode == 401 &&
//           error.response?.data['message'] == "Invalid JWT")) {
//         if (await _storage.containsKey(key: 'refreshToken')) {
//           if (await refreshToken()) {
//             return handler.resolve(await _retry(error.requestOptions));
//           }
//         }
//       }
//       return handler.next(error);
//     }));
//   }
//
//   Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     return api.request<dynamic>(requestOptions.path,
//         data: requestOptions.data,
//         queryParameters: requestOptions.queryParameters,
//         options: options);
//   }
//
//   Future<bool> refreshToken() async {
//     final refreshToken = await _storage.read(key: 'refreshToken');
//     final response = await api
//         .post('/auth/refresh', data: {'refreshToken': refreshToken});
//
//     if (response.statusCode == 201) {
//       accessToken = response.data;
//       return true;
//     } else {
//       // refresh token is wrong
//       accessToken = null;
//       _storage.deleteAll();
//       return false;
//     }
//   }
// }
// */
//
// class AuthRepository {
//   static final Dio api = locator.get(instanceName: 'dio');
//
//   static const _storage = FlutterSecureStorage(
//     aOptions: AndroidOptions(
//       encryptedSharedPreferences: true,
//     ),
//   );
//
//   const AuthRepository({required this.wrapper});
//
//   final InterceptorsWrapper wrapper;
//
//   void init() {
//     api.interceptors.add(wrapper);
//     api.interceptors.add(LoggingInterceptor());
//   }
//
//   void dispose() {
//     api.interceptors.remove(wrapper);
//     api.interceptors.remove(LoggingInterceptor());
//   }
//
//   static Future<String?> readUserJwt() async {
//     return _storage.read(key: 'jwt');
//   }
//
//   static Future<String?> readRefreshJwt() async {
//     return _storage.read(key: 'refresh_jwt');
//   }
//
//   static Future<bool> hasJwt() async {
//     return await _storage.containsKey(key: 'jwt');
//   }
//
//   static Future<bool> hasRefreshJwt() async {
//     return await _storage.containsKey(key: 'refresh_jwt');
//   }
//
//   static Future<void> saveUserJwt(String token) async {
//     await _storage.write(key: 'jwt', value: token);
//   }
//
//   static Future<void> saveUserJwtR(String token) async {
//     await _storage.write(key: 'refresh_jwt', value: token);
//   }
//
//   static Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     return AuthRepository.api.request<dynamic>(
//         requestOptions.baseUrl + requestOptions.path,
//         data: requestOptions.data,
//         queryParameters: requestOptions.queryParameters,
//         options: options);
//   }
//
//   // Future<void> saveToken(String token) async {
//   //   await _storage.write(key: 'jwt_token', value: token);
//   // }
//
//   // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//   //   final options = Options(
//   //     method: requestOptions.method,
//   //     headers: requestOptions.headers,
//   //   );
//   //   return api.request<dynamic>(requestOptions.path,
//   //       data: requestOptions.data,
//   //       queryParameters: requestOptions.queryParameters,
//   //       options: options);
//   // }
//
//   static Future<User> loadUser() async {
//     final id = await loadUserId();
//     final response = await api.get('$baseUrl/auth/users/$id');
//
//     switch (response.statusCode) {
//       case 200:
//         final data = response.data as Map<String, dynamic>;
//         return User.fromJson(data);
//       case 400:
//         final json = jsonDecode(response.data);
//         throw handleFormErrors(json);
//       case 300:
//       case 500:
//       default:
//         throw FormGeneralException(message: 'Error contacting the server!');
//     }
//   }
//
//   static Future<int> loadUserId() async {
//     final id = await _storage.read(
//       key: 'userId',
//     );
//     if (id != null) {
//       return int.parse(id);
//     } else {
//       throw SecureStorageNotFoundException();
//     }
//   }
//
//   static Future<void> saveUserId(User user) async {
//     await _storage.write(
//       key: 'userId',
//       value: user.id.toString(),
//     );
//   }
//
//   static Future<bool> refreshToken() async {
//     final refreshToken = await _storage.read(key: 'refreshToken');
//     final response = await api
//         .post('$baseUrl/auth/refresh', data: {'refreshToken': refreshToken});
//
//     if (response.statusCode == 201) {
//       await saveUserJwt(response.data['jwt']);
//       await saveUserJwtR(response.data['jwtR']);
//       return true;
//     } else {
//       _storage.deleteAll();
//       return false;
//     }
//   }
//
//   static Future<User> register({
//     required String email,
//     required String password,
//     required String phone,
//     required String name,
//     required String surname,
//   }) async {
//     final response = await api.post(
//       '$baseUrl/auth/register',
//       data: jsonEncode(
//         {
//           'email': email,
//           'password': password,
//           'name': name,
//           'surname': surname,
//           'phone': phone
//         },
//       ),
//     );
//
//     switch (response.statusCode) {
//       case 200:
//         final data = response.data as Map<String, dynamic>;
//         final json = data['user'] as Map<String, dynamic>;
//         final User user = User.fromJson(json);
//
//         await saveUserId(user);
//
//         return user;
//       case 400:
//         final json = jsonDecode(response.data);
//         throw handleFormErrors(json);
//       case 300:
//       case 500:
//       default:
//         throw FormGeneralException(message: 'Error contacting the server!');
//     }
//   }
//
//   static Future<void> logout() async {
//     await _storage.deleteAll();
//   }
//
//   static Future<User> login({
//     required String email,
//     required String password,
//   }) async {
//     final response = await api.post(
//       '$baseUrl/auth/authentication',
//       data: jsonEncode(
//         {
//           'email': email,
//           'password': password,
//         },
//       ),
//     );
//
//     switch (response.statusCode) {
//       case 200:
//         final data = response.data as Map<String, dynamic>;
//         final json = data['user'] as Map<String, dynamic>;
//         final User user = User.fromJson(json);
//
//         await saveUserId(user);
//
//         return user;
//       case 400:
//         final json = jsonDecode(response.data);
//         throw handleFormErrors(json);
//       case 300:
//       case 500:
//       default:
//         throw FormGeneralException(message: 'Error contacting the server!');
//     }
//   }
// }
