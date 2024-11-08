import 'package:dio/dio.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/api/urls.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:retrofit/http.dart';

part 'tour_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class TourService {
  factory TourService(Dio dio, {String baseUrl}) = _TourService;

  @GET('${Urls.toursByCity}/{user_id}')
  Future<List<TourDto>> getToursByCity({
    @Path('user_id') required String userId,
    @Query('city') required String city,
    @Query('offset') required int offset,
  });

  @GET(Urls.toursByAdmin)
  Future<List<TourDto>> getCreatedTours({
    @Query('offset') required int offset,
  });

  @GET('${Urls.audioTour}/{user_id}')
  Future<List<TourDto>> getCreatedToursByUser({
    @Path('user_id') required String userId,
    @Query('offset') required int offset,
  });

  @GET(Urls.audioTour)
  Future<List<TourDto>> getCreatedToursByAdmin({
    @Query('offset') required int offset,
  });

  @PUT(Urls.likeTour)
  Future<void> likeTour({
    @Query('user_id') required String userId,
    @Query('tour_id') required String tourId,
  });

  @GET('${Urls.likeTour}/{user_id}')
  Future<List<TourDto>> getLikedToursByUser({
    @Path('user_id') required String userId,
    @Query('offset') required int offset,
  });

  @POST('${Urls.createTour}/{user_id}')
  Future<void> createTour({
    @Path('user_id') required String userId,
    @Body() required Tour tour,
  });

  @DELETE('${Urls.audioTour}/{tour_id}')
  Future<void> deleteTour({
    @Path('tour_id') required String tourId,
  });
}