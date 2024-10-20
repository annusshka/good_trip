import 'package:dio/dio.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/api/api_urls.dart';
import 'package:good_trip/core/data/models/api_tour/api_tour_list_dto.dart';
import 'package:good_trip/core/data/models/api_tour/api_tour_property.dart';
import 'package:retrofit/http.dart';

part 'api_tour_service.g.dart';

@RestApi(baseUrl: apiTourUrl)
abstract class ApiTourService {
  factory ApiTourService(Dio dio, {String baseUrl}) = _ApiTourService;

  @GET(ApiUrls.tourList)
  Future<ApiTourListDto> getTourList({
    @Query('radius') required int radius,
    @Query('lon') required double lon,
    @Query('lat') required double lat,
    @Query('limit') required int limit,
    @Query('apikey') required String apikey,
  });

  @GET('${ApiUrls.tourDetails}/{idEvent}')
  Future<ApiTourProperty> getTourDetails({
    @Path('idEvent') required String idEvent,
    @Query('apikey') required String apikey,
  });
}