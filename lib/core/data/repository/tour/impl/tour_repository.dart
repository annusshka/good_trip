import 'package:dio/dio.dart';
import 'package:good_trip/core/data/mapper/mapper.dart';
import 'package:good_trip/core/data/models/exception/tour_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/service/service.dart';

class TourRepository implements ITourRepository {
  TourRepository({required this.service});

  final TourService service;

  @override
  Future<List<AudioTour>> getAudioTours({
    required int userId,
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  }) async {
    try {
      //int userId = await AuthRepository().loadUserId();
      final response = await service.getToursByCity(
          userId: userId.toString(), city: city, offset: offset);
      return mapDtoToAudioTourList(response);
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
  Future<List<AudioTour>> getCreatedTourList({int offset = 0}) async {
    try {
      final response = await service.getCreatedTours(offset: offset);
      return mapDtoToAudioTourList(response);
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
  Future<List<AudioTour>> getCreatedTourListByAdmin({int offset = 0}) async {
    try {
      final response = await service.getCreatedToursByAdmin(offset: offset);
      return mapDtoToAudioTourList(response);
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
  Future<List<AudioTour>> getCreatedTourListByUserId({
    required int userId,
    int offset = 0,
  }) async {
    try {
      //int userId = await AuthRepository.loadUserId();
      final response = await service.getCreatedToursByUser(
        offset: offset,
        userId: userId.toString(),
      );
      return mapDtoToAudioTourList(response);
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
      await service.likeTour(
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
  Future<List<AudioTour>> getFavoriteTourList(
      {required int userId, int offset = 0}) async {
    try {
      final response = await service.getLikedToursByUser(
        userId: userId.toString(),
        offset: offset,
      );
      return mapDtoToAudioTourList(response);
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
  Future<void> deleteTour({
    required String id,
  }) async {
    try {
      //int userId = await AuthRepository.loadUserId();
      await service.deleteTour(
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
}
