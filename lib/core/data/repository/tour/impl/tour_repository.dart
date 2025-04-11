import 'dart:convert';
import 'dart:io';

import 'package:day_picker/day_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/core/data/mapper/tour_mapper.dart';
import 'package:good_trip/core/data/models/exception/secure_storage_exception.dart';
import 'package:good_trip/core/data/models/exception/tour_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/service/service.dart';

class TourRepository implements ITourRepository {
  final TourService service;
  final FlutterSecureStorage _storage;

  TourRepository({
    required this.service,
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  }) : _storage = storage;

  Future<String> loadUserId() async {
    final id = await _storage.read(
      key: 'user_id',
    );
    if (id != null) {
      return id;
    } else {
      throw SecureStorageNotFoundException();
    }
  }

  @override
  Future<List<Tour>> getTours({
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  }) async {
    try {
      String userId = await loadUserId();
      final response = await service.getToursByCity(city: city, offset: offset, userId: userId);
      return mapDtoToTours(response);
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
  Future<List<Tour>> getCreatedTours({int offset = 0}) async {
    try {
      final response = await service.getCreatedTours(offset: offset);
      return mapDtoToTours(response);
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
  Future<List<Tour>> getCreatedToursByAdmin({int offset = 0}) async {
    try {
      final response = await service.getCreatedToursByAdmin(offset: offset);
      return mapDtoToTours(response);
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
  Future<List<Tour>> getCreatedToursByUserId({
    required int userId,
    int offset = 0,
  }) async {
    try {
      //int userId = await AuthRepository.loadUserId();
      final response = await service.getCreatedToursByUser(
        offset: offset,
        userId: userId.toString(),
      );
      return mapDtoToTours(response);
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
  Future<List<Tour>> getFavoriteTours(
      {required int userId, int offset = 0}) async {
    try {
      final response = await service.getLikedToursByUser(
        userId: userId.toString(),
        offset: offset,
      );
      return mapDtoToTours(response);
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

  @override
  Future<int> getViewedExcursionCount({required String tourId}) async {
    final count = await _storage.read(
      key: 'tour_$tourId',
    );
    return int.tryParse(count ?? '0') ?? 0;
  }

  @override
  Future<void> viewExcursions({
    required String tourId,
    required int excursionCount,
  }) async {
    await _storage.write(
      key: 'tour_$tourId',
      value: jsonEncode(excursionCount),
    );
  }

  @override
  Future<void> saveTour({
    required String name,
    required String imagePath,
    required List<DayInWeek> weekdays,
    required String description,
    required List<String> kinds,
    required Address address,
    required File? imageFile,
    required List<IAudioExcursion> excursionList,
  }) {
    // TODO: implement saveTour
    throw UnimplementedError();
  }
}
