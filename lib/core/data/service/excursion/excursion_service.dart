import 'dart:io';

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
  Future<int> createExcursion({
    @Body() required AudioExcursionDto excursion,
  });

  @POST(Urls.createExcursionImage)
  @MultiPart()
  Future<int> createExcursionImage({
    @Part(name: 'excursion_id') required int excursionId,
    @Part(name: 'image') required File image,
  });

  @POST(Urls.createExcursionAudio)
  @MultiPart()
  Future<int> createExcursionAudio({
    @Part(name: 'excursion_id') required int excursionId,
    @Part(name: 'audio') required File audio,
  });

  @DELETE(Urls.audioExcursion)
  Future<void> deleteExcursion({
    @Query('excursion_id') required String excursionId,
  });

  @GET(Urls.excursionTypes)
  Future<List<TourKind>> getExcursionTypes();
}
