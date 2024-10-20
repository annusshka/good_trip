import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/models/tour/tour_kind.dart';

abstract class ITourRepository {
  Future<List<AudioTour>> getAudioTours({
    required int userId,
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  });

  Future<List<AudioTour>> getCreatedTourList({int offset = 0});

  Future<List<AudioTour>> getCreatedTourListByUserId({
    required int userId,
    int offset = 0,
  });

  Future<List<AudioTour>> getCreatedTourListByAdmin({int offset = 0});

  Future<void> likeTour({
    required int userId,
    required String id,
  });

  Future<List<AudioTour>> getFavoriteTourList({
    required int userId,
    int offset = 0,
  });

  Future<void> deleteTour({
    required String id,
  });

  Future<List<TourKind>> getTourTypes();
}
