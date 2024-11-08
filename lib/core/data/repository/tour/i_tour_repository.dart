import 'package:good_trip/core/data/models/models.dart';

abstract class ITourRepository {
  Future<List<Tour>> getTours({
    required int userId,
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  });

  Future<List<Tour>> getCreatedTours({int offset = 0});

  Future<List<Tour>> getCreatedToursByUserId({
    required int userId,
    int offset = 0,
  });

  Future<List<Tour>> getCreatedToursByAdmin({int offset = 0});

  Future<void> likeTour({
    required int userId,
    required String id,
  });

  Future<List<Tour>> getFavoriteTours({
    required int userId,
    int offset = 0,
  });

  Future<void> deleteTour({
    required String id,
  });
}
