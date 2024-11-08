import 'package:dio/dio.dart';
import 'package:good_trip/core/data/mapper/mapper.dart';
import 'package:good_trip/core/data/models/exception/tour_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/service/service.dart';

class ExcursionRepository implements IExcursionRepository {
  ExcursionRepository({required this.service});

  final ExcursionService service;

  @override
  Future<List<AudioExcursion>> getAudioExcursions({
    required int userId,
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  }) async {
    try {
      //int userId = await AuthRepository().loadUserId();
      final response = await service.getExcursionsByCity(
          userId: userId.toString(), city: city, offset: offset);
      return mapDtoToAudioExcursionList(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetAudioTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<AudioExcursion>> getCreatedExcursionList({int offset = 0}) async {
    try {
      final response = await service.getCreatedExcursions(offset: offset);
      return mapDtoToAudioExcursionList(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<AudioExcursion>> getCreatedExcursionListByAdmin({int offset = 0}) async {
    try {
      final response = await service.getCreatedExcursionsByAdmin(offset: offset);
      return mapDtoToAudioExcursionList(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<AudioExcursion>> getCreatedExcursionListByUserId({
    required int userId,
    int offset = 0,
  }) async {
    try {
      //int userId = await AuthRepository.loadUserId();
      final response = await service.getCreatedExcursionsByUser(
        offset: offset,
        userId: userId.toString(),
      );
      return mapDtoToAudioExcursionList(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> likeTour({
    required int userId,
    required String id,
  }) async {
    try {
      //int userId = await AuthRepository.loadUserId();
      await service.likeExcursion(
        userId: userId.toString(),
        tourId: id,
      );
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<AudioExcursion>> getFavoriteExcursionList(
      {required int userId, int offset = 0}) async {
    try {
      final response = await service.getLikedExcursionsByUser(
        userId: userId.toString(),
        offset: offset,
      );
      return mapDtoToAudioExcursionList(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetFavoriteTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteExcursion({
    required String id,
  }) async {
    try {
      //int userId = await AuthRepository.loadUserId();
      await service.deleteExcursion(
        tourId: id,
      );
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<TourKind>> getExcursionTypes() async {
    try {
      //int userId = await AuthRepository.loadUserId();
      return await service.getExcursionTypes();
    } on DioException catch (error) {
      throw TourError(
        name: 'GetTouTypes',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
