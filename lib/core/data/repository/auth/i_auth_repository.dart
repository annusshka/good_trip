import 'package:good_trip/core/data/models/models.dart';

abstract class IAuthRepository {
  Future<User> loadUser();

  Future<int?> loadUserId();

  Future<User> register({required AuthRequest authRequest});

  Future<void> logout();

  Future<User> login({required LoginRequest loginRequest});
}
