import 'package:dio/dio.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/api/urls.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:retrofit/http.dart';

part 'excursion_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ExcursionService {
  factory ExcursionService(Dio dio, {String baseUrl}) = _ExcursionService;

  @GET('${Urls.excursionsByCity}/{user_id}')
  Future<List<AudioExcursionDto>> getExcursionsByCity({
    @Path('user_id') required String userId,
    @Query('city') required String city,
    @Query('offset') required int offset,
  });

  @GET(Urls.excursionsByAdmin)
  Future<List<AudioExcursionDto>> getCreatedExcursions({
    @Query('offset') required int offset,
  });

  @GET('${Urls.audio}/{user_id}')
  Future<List<AudioExcursionDto>> getCreatedExcursionsByUser({
    @Path('user_id') required String userId,
    @Query('offset') required int offset,
  });

  @GET(Urls.audio)
  Future<List<AudioExcursionDto>> getCreatedExcursionsByAdmin({
    @Query('offset') required int offset,
  });

  @PUT(Urls.likeExcursion)
  Future<void> likeExcursion({
    @Query('user_id') required String userId,
    @Query('tour_id') required String tourId,
  });

  @GET('${Urls.likeExcursion}/{user_id}')
  Future<List<AudioExcursionDto>> getLikedExcursionsByUser({
    @Path('user_id') required String userId,
    @Query('offset') required int offset,
  });

  @POST('${Urls.createExcursion}/{user_id}')
  Future<void> createExcursion({
    @Path('user_id') required String userId,
    @Body() required Excursion excursion,
  });

  @DELETE('${Urls.audio}/{tour_id}')
  Future<void> deleteExcursion({
    @Path('tour_id') required String tourId,
  });

  @GET(Urls.excursionTypes)
  Future<List<TourKind>> getExcursionTypes();
}
