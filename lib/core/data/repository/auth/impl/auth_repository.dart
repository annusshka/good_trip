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
      final id = await loadUserId();
      if (id == null) assert(id == null, 'userId is null');
      final response = await service.getUserById(userId: id.toString());
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
      key: 'userId',
    );
    if (id != null) {
      return int.tryParse(id);
    } else {
      throw SecureStorageNotFoundException();
    }
  }

  Future<void> saveUserId(User user) async {
    await _storage.write(
      key: 'userId',
      value: user.id.toString(),
    );
  }

  @override
  Future<User> login({required LoginRequest loginRequest}) async {
    try {
      final response = await service.login(loginRequest: loginRequest);
      final user = mapDtoToUser(response);
      await saveUserId(user);

      return user;
    } on DioException catch (error) {
      throw AuthError(
        name: 'LoginError',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    }
  }

  @override
  Future<User> register({required AuthRequest authRequest}) async {
    try {
      final response = await service.register(authRequest: authRequest);
      final user = mapDtoToUser(response);
      await saveUserId(user);
      return user;
    } on DioException catch (error) {
      throw AuthError(
        name: 'RegisterError',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    }
  }

  @override
  Future<void> logout() async {
    await _storage.deleteAll();
  }
}
