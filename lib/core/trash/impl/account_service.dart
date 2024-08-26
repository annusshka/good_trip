// import 'package:good_trip/core/data/api/api_key.dart';
// import 'package:good_trip/core/data/models/models.dart';
// import 'package:good_trip/core/trash/dio_client.dart';
//
// class AccountService {
//
//   // Future<void> addAccount(Account account) async {
//   //   //final response = await Dio().post("path");
//   //   //accountList.add(account);
//   // }
//
//   Future<List<User>> getAccountList() async {
//     final response = await DioClient().apiDio.get('$baseUrl/auth/admin/users');
//     final data = response.data as List<dynamic>;
//
//     final dataList = data
//         .map((e) => User(
//             id: e['id'],
//             name: e['name'],
//             surname: e['surname'],
//             email: e['email'],
//             phone: e['phone'],
//             password: '',
//             role: AccessLevel.USER,
//             accessToken: '',
//             refreshToken: ''))
//         .toList();
//     return dataList;
//   }
//
//   Future<void> removeAccount(int accountId) async {
//     final response = await DioClient().apiDio.delete("$baseUrl/auth/admin/user/$accountId");
//     if (response.statusCode == 202) {
//       return;
//     } else {
//       throw Exception();
//     }
//   }
// }
