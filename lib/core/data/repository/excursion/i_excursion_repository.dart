import 'package:good_trip/core/data/models/models.dart';

abstract class IExcursionRepository {
  Future<List<AudioExcursion>> getAudioExcursions({
    required int userId,
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  });

  Future<List<AudioExcursion>> getCreatedExcursionList({int offset = 0});

  Future<List<AudioExcursion>> getCreatedExcursionListByUserId({
    required int userId,
    int offset = 0,
  });

  Future<List<AudioExcursion>> getCreatedExcursionListByAdmin({int offset = 0});

  Future<void> likeTour({
    required int userId,
    required String id,
  });

  Future<List<AudioExcursion>> getFavoriteExcursionList({
    required int userId,
    int offset = 0,
  });

  Future<void> deleteExcursion({
    required String id,
  });

  Future<List<TourKind>> getExcursionTypes();
}
