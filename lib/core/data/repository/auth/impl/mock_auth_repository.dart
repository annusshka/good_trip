import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/core/data/models/exception/auth_error.dart';
import 'package:good_trip/core/data/models/exception/secure_storage_exception.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/auth/i_auth_repository.dart';
import 'package:good_trip/core/data/service/auth/auth_service.dart';

class MockAuthRepository extends IAuthRepository {
  final AuthService service;
  final FlutterSecureStorage _storage;

  MockAuthRepository({
    required this.service,
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  }) : _storage = storage;

  static List<User> userList = [
    const User(
      id: 1,
      email: 'test@gmail.com',
      name: 'user1',
      surname: 'surname',
      phone: '71001001010',
      password: 'test11',
      role: AccessLevel.USER,
    )
  ];

  @override
  Future<User> loadUser() async {
    try {
      final id = await loadUserId();
      if (id == null) assert(id == null, 'userId is null');
      for (final User user in userList) {
        if (user.id == id) return user;
      }
      throw AuthError(
        name: 'LoadUserError',
        message: 'User not found',
        errorText: 'User not found',
      );
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

  Future<void> saveUserId(int userId) async {
    await _storage.write(
      key: 'userId',
      value: userId.toString(),
    );
  }

  @override
  Future<User> login({required LoginRequest loginRequest}) async {
    try {
      for (final User user in userList) {
        if (user.email == loginRequest.email &&
            user.password == loginRequest.password) {
          await saveUserId(user.id);
          return user;
        }
      }
      throw AuthError(
        name: 'LoginError',
        message: 'User not found',
        errorText: 'User not found',
      );
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
      final id = userList.isNotEmpty ? userList[userList.length - 1].id : 1;
      final user = User(
        id: id,
        email: authRequest.email,
        name: authRequest.name,
        surname: authRequest.surname,
        phone: authRequest.phone,
        password: authRequest.password,
        role: AccessLevel.USER,
      );
      userList.add(user);
      await saveUserId(user.id);
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
