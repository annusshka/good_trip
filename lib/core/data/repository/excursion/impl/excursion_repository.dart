import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/core/data/mapper/tour_mapper.dart';
import 'package:good_trip/core/data/models/exception/tour_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/service/service.dart';

class ExcursionRepository implements IExcursionRepository {
  ExcursionRepository({
    required this.service,
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  }) : _storage = storage;

  final ExcursionService service;
  final FlutterSecureStorage _storage;

  @override
  Future<List<AudioExcursion>> getAudioExcursions({
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  }) async {
    try {
      final response = await service.getExcursionsByCity(
        city: city,
        offset: offset,
      );
      return mapDtoToAudioExcursionList(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetAudioTourList',
        message: error.response?.data['message'] ?? '',
        errorText: error.response?.data['errorText'] ?? '',
        statusCode: error.response?.statusCode,
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
        message: error.response?.data['message'] ?? '',
        errorText: error.response?.data['errorText'] ?? '',
        statusCode: error.response?.statusCode,
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
        message: error.response?.data['message'] ?? '',
        errorText: error.response?.data['errorText'] ?? '',
        statusCode: error.response?.statusCode,
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<AudioExcursion>> getCreatedExcursionListByUserId({
    int offset = 0,
  }) async {
    try {
      final response = await service.getCreatedExcursionsByUser(offset: offset);
      return mapDtoToAudioExcursionList(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'] ?? '',
        errorText: error.response?.data['errorText'] ?? '',
        statusCode: error.response?.statusCode,
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> likeAudioExcursion({
    required String id,
    required bool isLiked,
  }) async {
    try {
      await service.likeExcursion(excursionId: id, isLiked: isLiked);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'] ?? '',
        errorText: error.response?.data['errorText'] ?? '',
        statusCode: error.response?.statusCode,
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<AudioExcursion>> getFavoriteExcursionList({int offset = 0}) async {
    try {
      final response = await service.getLikedExcursionsByUser(offset: offset);
      return mapDtoToAudioExcursionList(response);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetFavoriteTourList',
        message: error.response?.data['message'] ?? '',
        errorText: error.response?.data['errorText'] ?? '',
        statusCode: error.response?.statusCode,
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
      await service.deleteExcursion(excursionId: id);
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'] ?? '',
        errorText: error.response?.data['errorText'] ?? '',
        statusCode: error.response?.statusCode,
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveExcursion({
    required AudioExcursionDto audioExcursion,
    required String? imagePath,
    required String? audioPath,
  }) async {
    int? excursionId;
    try {
      final File imageFile = File(imagePath ?? '');
      excursionId = await service.createExcursion(excursion: audioExcursion);
      final int excursionId2 = await service.createExcursionImage(excursionId: excursionId, image: imageFile);
    } on DioException catch (error) {
      throw TourError(
        name: 'SaveExcursion',
        message: error.response?.data['message'] ?? '',
        errorText: error.response?.data['errorText'] ?? '',
        statusCode: error.response?.statusCode,
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }

    try {
      final File audioFile = File(audioPath ?? '');
      final int excursionId3 = await service.createExcursionAudio(excursionId: excursionId, audio: audioFile);
    } catch (_) {}
  }
}
