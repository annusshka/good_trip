import 'package:dio/dio.dart';
import 'package:good_trip/core/data/mapper/mapper_export.dart';
import 'package:good_trip/core/data/models/exception/account_list_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart';
import 'package:good_trip/features/account_list/data/service/account_list_service.dart';

class AccountListRepository implements IAccountListRepository {
  AccountListRepository({required this.service});

  final AccountListService service;

  @override
  Future<List<User>> getAccountList() async {
    try {
      final response = await service.getAccountList();
      return mapDtoToUserList(response);
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
      await service.removeAccount(accountId: accountId);
    } on DioException catch (error) {
      throw AccountListError(
        name: 'DeleteAccountByAdminError',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    }
  }
}
