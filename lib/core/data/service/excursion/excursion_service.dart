import 'package:dio/dio.dart';
import 'package:good_trip/core/data/api/urls.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:retrofit/http.dart';

part 'excursion_service.g.dart';

@RestApi()
abstract class ExcursionService {
  factory ExcursionService(Dio dio, {String baseUrl}) = _ExcursionService;

  @GET(Urls.excursionsByCity)
  Future<List<AudioExcursionDto>> getExcursionsByCity({
    @Query('city') required String city,
    @Query('offset') required int offset,
  });

  @GET(Urls.excursionsByAdmin)
  Future<List<AudioExcursionDto>> getCreatedExcursions({
    @Query('offset') required int offset,
  });

  @GET(Urls.createdExcursion)
  Future<List<AudioExcursionDto>> getCreatedExcursionsByUser({
    @Query('offset') required int offset,
  });

  @GET(Urls.createdExcursion)
  Future<List<AudioExcursionDto>> getCreatedExcursionsByAdmin({
    @Query('offset') required int offset,
  });

  @PUT(Urls.likeExcursion)
  Future<void> likeExcursion({
    @Query('excursion_id') required String excursionId,
    @Query('is_liked') required bool isLiked,
  });

  @GET(Urls.likeExcursion)
  Future<List<AudioExcursionDto>> getLikedExcursionsByUser({
    @Query('offset') required int offset,
  });

  @POST(Urls.createExcursion)
  Future<void> createExcursion({
    @Body() required AudioExcursion excursion,
    @Body() required MultipartFile audioFile,
    @Body() required MultipartFile imageFile,
  });

  @DELETE('${Urls.audioExcursion}/{tour_id}')
  Future<void> deleteExcursion({
    @Path('tour_id') required String tourId,
  });

  @GET(Urls.excursionTypes)
  Future<List<TourKind>> getExcursionTypes();
}
