import 'package:dio/dio.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/api/urls.dart';
import 'package:good_trip/features/welcome/data/models/welcome_info/welcome_info.dart';
import 'package:retrofit/retrofit.dart';

part 'welcome_info_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class WelcomeInfoService {
  factory WelcomeInfoService(Dio dio, {String baseUrl}) = _WelcomeInfoService;

  @GET(Urls.welcome)
  Future<List<WelcomeInfo>> getWelcomeInfoList();
}
