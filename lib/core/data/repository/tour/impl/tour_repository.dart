import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/core/data/mapper/tour_mapper.dart';
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

  @override
  Future<List<Tour>> getTours({
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  }) async {
    try {
      final response = await service.getToursByCity(city: city, offset: offset);
      return mapDtoToTours(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetAudioTourList',
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
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
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
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
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Tour>> getCreatedToursByUserId({
    int offset = 0,
  }) async {
    try {
      final response = await service.getCreatedToursByUser(
        offset: offset,
      );
      return mapDtoToTours(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> likeTour({
    required String id,
    required bool isLiked,
  }) async {
    try {
      await service.likeTour(
        tourId: id,
        isLiked: isLiked,
      );
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Tour>> getFavoriteTours({int offset = 0}) async {
    try {
      final response = await service.getLikedToursByUser(
        offset: offset,
      );
      return mapDtoToTours(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetFavoriteTourList',
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
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
      await service.deleteTour(
        tourId: id,
      );
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
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
    required TourDto tour,
    required String? imagePath,
  }) async {
    try {
      final File imageFile = File(imagePath ?? '');
      final int tourId = await service.createTour(tour: tour);
      final int tourId2 = await service.createTourFiles(tourId: tourId, image: imageFile);
    } on DioException catch (error) {
      throw TourError(
        name: 'SaveExcursion',
        message: error.response?.data?['message'] ?? '',
        errorText: error.response?.data?['errorText'] ?? '',
        statusCode: error.response?.statusCode,
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
