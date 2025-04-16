import 'package:good_trip/core/data/models/models.dart';

abstract class IExcursionRepository {
  Future<List<AudioExcursion>> getAudioExcursions({
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  });

  Future<List<AudioExcursion>> getCreatedExcursionList({int offset = 0});

  Future<List<AudioExcursion>> getCreatedExcursionListByUserId({int offset = 0});

  Future<List<AudioExcursion>> getCreatedExcursionListByAdmin({int offset = 0});

  Future<void> likeAudioExcursion({required String id, required bool isLiked});

  Future<List<AudioExcursion>> getFavoriteExcursionList({int offset = 0});

  Future<void> deleteExcursion({required String id});

  Future<void> saveExcursion({
    required AudioExcursionDto audioExcursion,
    required String? imagePath,
    required String? audioPath
  });
}
