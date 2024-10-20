import 'package:dio/dio.dart';
import 'package:good_trip/core/data/models/exception/account_list_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/auth/impl/mock_auth_repository.dart';
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart';
import 'package:good_trip/features/account_list/data/service/account_list_service.dart';

class MockAccountListRepository implements IAccountListRepository {
  MockAccountListRepository({required this.service});

  final AccountListService service;

  @override
  Future<List<User>> getAccountList() async {
    try {
      return MockAuthRepository.userList;
    } on DioException catch (error) {
      throw AccountListError(
        name: 'GetAccountListError',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    }
  }

  @override
  Future<void> removeAccount({
    required int accountId,
  }) async {
    try {
      for (final User user in MockAuthRepository.userList) {
        if (user.id == accountId) MockAuthRepository.userList.remove(user);
      }
    } on DioException catch (error) {
      throw AccountListError(
        name: 'DeleteAccountByAdminError',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    }
  }
}
