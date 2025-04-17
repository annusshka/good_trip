import 'package:good_trip/core/data/models/models.dart';

abstract class ITourRepository {
  Future<List<Tour>> getTours({
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  });

  Future<List<Tour>> getCreatedTours({int offset = 0});

  Future<List<Tour>> getCreatedToursByUserId({int offset = 0});

  Future<List<Tour>> getCreatedToursByAdmin({int offset = 0});

  Future<void> likeTour({
    required String id,
    required bool isLiked,
  });

  Future<List<Tour>> getFavoriteTours({int offset = 0});

  Future<void> saveTour({
    required TourDto tour,
    required String? imagePath,
  });

  Future<void> deleteTour({required String id});

  Future<int> getViewedExcursionCount({required String tourId});

  Future<void> viewExcursions({
    required String tourId,
    required int excursionCount,
  });
}
