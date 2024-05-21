import 'package:dio/dio.dart';
import 'package:good_trip/core/domain/service/dio_client.dart';

import '../../../../core/data/api/api_key.dart';
import '../../../../core/domain/models/models.dart';

class AccountService {
  Dio dio = DioClient().dio;

  // Future<void> addAccount(Account account) async {
  //   //final response = await Dio().post("path");
  //   //accountList.add(account);
  // }

  Future<List<User>> getAccountList() async {
    final response = await dio.get("$baseUrl/auth/admin/users");
    final data = response.data as List<dynamic>;

    final dataList = data
        .map((e) => User(
            id: e['id'],
            name: e['name'],
            surname: e['surname'],
            email: e['email'],
            phone: e['phone'],
            password: '',
            role: AccessLevel.USER,
            accessToken: '',
            refreshToken: ''))
        .toList();
    return dataList;
  }

  Future<void> removeAccount(int accountId) async {
    final response = await dio.delete("$baseUrl/auth/admin/user/$accountId");
    if (response.statusCode == 202) {
      return;
    } else {
      throw Exception();
    }
  }
}
