import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/mapper/tour_mapper.dart';
import 'package:good_trip/core/data/models/api_tour/api_tour_dto.dart';
import 'package:good_trip/core/data/models/exception/tour_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/api_tour/i_api_tour_repository.dart';

class ApiTourRepository extends IApiTourRepository {
  ApiTourRepository({required super.service});

  @override
  Future<List<Excursion>> getExcursionList({
    int radius = 10000,
    required double lon,
    required double lat,
    int limit = 10,
  }) async {
    try {
      final response = await service.getTourList(
          radius: radius, lon: lon, lat: lat, limit: limit, apikey: tripKey);
      // final dataFeatures = response['features'];
      //
      // List<Tour> dataList = [];
      // for (final Map<String, dynamic> actData in dataFeatures) {
      //   Map<String, dynamic> prop = actData['properties'];
      //   dataList.add(
      //     await getTourDetails(
      //       idEvent: prop['xid'],
      //     ),
      //   );
      // }
      //
      // return dataList;

      List<Excursion> apiTourList = [];
      for (final ApiTourDto apiTourDto in response.features) {
        final Excursion? tour = await getExcursionDetails(idEvent: apiTourDto.id);
        if (tour != null) apiTourList.add(tour);
      }
      return apiTourList;
    } on DioException catch (error) {
      throw TourError(
        name: 'GetTourListByApi',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Excursion?> getExcursionDetails({required String idEvent}) async {
    try {
      final response =
          await service.getTourDetails(idEvent: idEvent, apikey: tripKey);
      return mapApiResponseToTour(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    } on Error catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
