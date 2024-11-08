import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/service/api_tour/api_tour_service.dart';

abstract class IApiTourRepository {
  final ApiTourService service;

  IApiTourRepository({required this.service});

  Future<List<Excursion>> getExcursionList({
    int radius = 10000,
    required double lon,
    required double lat,
    int limit = 10,
  });

  Future<Excursion?> getExcursionDetails({required String idEvent});
}