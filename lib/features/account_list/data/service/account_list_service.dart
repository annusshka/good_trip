import 'package:dio/dio.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/api/urls.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:retrofit/http.dart';

part 'account_list_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AccountListService {
  factory AccountListService(Dio dio, {String baseUrl}) = _AccountListService;

  @GET(Urls.getAccountList)
  Future<List<UserDto>> getAccountList();

  @GET('${Urls.deleteAccountByAdmin}/{account_id}')
  Future<void> removeAccount({
    @Query('account_id') required int accountId,
  });
}
