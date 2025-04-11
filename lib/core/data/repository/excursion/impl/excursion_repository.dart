import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/core/data/mapper/tour_mapper.dart';
import 'package:good_trip/core/data/models/exception/secure_storage_exception.dart';
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
      final userId = await loadUserId();
      final response = await service.getExcursionsByCity(
        userId: userId,
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
      final userId = await loadUserId();
      final response = await service.getCreatedExcursionsByUser(
        offset: offset,
        userId: userId,
      );
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
  Future<void> likeTour({
    required String id,
  }) async {
    try {
      final userId = await loadUserId();
      await service.likeExcursion(
        userId: userId,
        tourId: id,
      );
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
      final userId = await loadUserId();
      final response = await service.getLikedExcursionsByUser(
        userId: userId,
        offset: offset,
      );
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
      await service.deleteExcursion(
        tourId: id,
      );
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
  Future<List<TourKind>> getExcursionTypes() async {
    try {
      //int userId = await AuthRepository.loadUserId();
      return await service.getExcursionTypes();
    } on DioException catch (error) {
      throw TourError(
        name: 'GetTouTypes',
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
    required AudioExcursion audioExcursion,
  }) async {
    try {
      final userId = await loadUserId();
      final MultipartFile imageFile = await MultipartFile.fromFile(audioExcursion.imageUrl!);
      final MultipartFile audioFile = await MultipartFile.fromFile(audioExcursion.audioUrl);
      //MultipartFile imageFile = MultipartFile.fromBytes(await photo!.readAsBytes());
      await service.createExcursion(
        userId: userId,
        excursion: audioExcursion,
        audioFile: audioFile,
        imageFile: imageFile,
      );
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
  }

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
}
