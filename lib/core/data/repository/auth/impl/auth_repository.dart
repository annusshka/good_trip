import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/core/data/mapper/mapper_export.dart';
import 'package:good_trip/core/data/models/exception/auth_error.dart';
import 'package:good_trip/core/data/models/exception/secure_storage_exception.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/auth/i_auth_repository.dart';
import 'package:good_trip/core/data/service/auth/auth_service.dart';

class AuthRepository extends IAuthRepository {
  final AuthService service;
  final FlutterSecureStorage _storage;

  AuthRepository({
    required this.service,
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  }) : _storage = storage;

  @override
  Future<User> loadUser() async {
    try {
      final response = await service.getUserById();
      return mapDtoToUser(response);
    } on DioException catch (error) {
      throw AuthError(
        name: 'LoadUserError',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    }
  }

  @override
  Future<int?> loadUserId() async {
    final id = await _storage.read(
      key: 'user_id',
    );
    if (id != null) {
      return int.tryParse(id);
    } else {
      throw SecureStorageNotFoundException();
    }
  }

  Future<void> saveUserId(User user) async {
    await _storage.write(
      key: 'user_id',
      value: user.id.toString(),
    );
  }

  @override
  Future<User> login({required LoginRequest loginRequest}) async {
    try {
      final response = await service.login(loginRequest: loginRequest);
      await saveUserJwt(response.token);
      await saveUserJwtR(response.refreshToken);
      final user = mapDtoToUser(response.user);
      await saveUserId(user);

      return user;
    } on DioException catch (error) {
      throw AuthError(
        name: 'RegisterError',
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
        statusCode: error.response?.statusCode,
      );
    } on Exception catch (error) {
      throw AuthError(
        name: 'RegisterError',
        message: error.toString(),
      );
    }
  }

  @override
  Future<User> register({required AuthRequest authRequest}) async {
    try {
      final response = await service.register(authRequest: authRequest);
      await saveUserJwt(response.token);
      await saveUserJwtR(response.refreshToken);
      final user = mapDtoToUser(response.user);
      await saveUserId(user);
      return user;
    } on DioException catch (error) {
      throw AuthError(
        name: 'RegisterError',
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
        statusCode: error.response?.statusCode,
      );
    } on Exception catch (error) {
      throw AuthError(
        name: 'RegisterError',
        message: error.toString(),
      );
    }
  }

  Future<void> saveUserJwt(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  Future<void> saveUserJwtR(String token) async {
    await _storage.write(key: 'refresh_jwt', value: token);
  }

  @override
  Future<void> logout() async {
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'refresh_jwt');
    await _storage.delete(key: 'user_id');
  }
}
