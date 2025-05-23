import 'dart:io';

import 'package:dio/dio.dart';
import 'package:good_trip/core/data/api/urls.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:retrofit/http.dart';

part 'tour_service.g.dart';

@RestApi()
abstract class TourService {
  factory TourService(Dio dio, {String baseUrl}) = _TourService;

  @GET(Urls.toursByCity)
  Future<List<TourDto>> getToursByCity({
    @Query('city') required String city,
    @Query('offset') required int offset,
  });

  @GET(Urls.toursByAdmin)
  Future<List<TourDto>> getCreatedTours({
    @Query('offset') required int offset,
  });

  @GET(Urls.createdTour)
  Future<List<TourDto>> getCreatedToursByUser({
    @Query('offset') required int offset,
  });

  @GET(Urls.audioTour)
  Future<List<TourDto>> getCreatedToursByAdmin({
    @Query('offset') required int offset,
  });

  @PUT(Urls.likeTour)
  Future<void> likeTour({
    @Query('tour_id') required String tourId,
    @Query('is_liked') required bool isLiked,
  });

  @GET(Urls.likeTour)
  Future<List<TourDto>> getLikedToursByUser({
    @Query('offset') required int offset,
  });

  @POST(Urls.createTour)
  Future<int> createTour({
    @Body() required TourDto tour,
  });

  @POST(Urls.createTourFiles)
  @MultiPart()
  Future<int> createTourFiles({
    @Part(name: 'tour_id') required int tourId,
    @Part(name: 'image') required File image,
  });

  @DELETE(Urls.audioTour)
  Future<void> deleteTour({
    @Query('tour_id') required String tourId,
  });
}