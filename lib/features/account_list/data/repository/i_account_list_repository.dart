import 'package:good_trip/core/data/models/models.dart';

abstract class IAccountListRepository {
  Future<List<User>> getAccountList();

  Future<void> removeAccount({
    required int accountId,
  });
}
