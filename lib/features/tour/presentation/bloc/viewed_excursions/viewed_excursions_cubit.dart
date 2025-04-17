import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'viewed_excursions.dart';

class ViewedExcursionsCubit extends Cubit<ViewedExcursionsState> {
  final ITourRepository tourRepository;

  ViewedExcursionsCubit({required this.tourRepository}) : super(const ViewedExcursionsState(excursionCount: 0));

  Future<void> requestViewedExcursion({required String tourId}) async {
    try {
      final viewedExcursions = await tourRepository.getViewedExcursionCount(tourId: tourId);
      emit(ViewedExcursionsState(excursionCount: viewedExcursions));
    } catch (e) {
      AppMetrica.reportErrorWithGroup(
        'Request viewed excursions level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  Future<void> requestViewExcursion({
    required String tourId,
    required int excursionCount,
    required int actualCount,
  }) async {
    if (excursionCount > actualCount) {
      try {
        await tourRepository.viewExcursions(
          tourId: tourId,
          excursionCount: excursionCount,
        );
        Map<String, String> attributesMap = {
          'tour': tourId,
          'view_count': excursionCount.toString(),
        };
        AppMetrica.reportEventWithMap('view_excursion', attributesMap);
        emit(ViewedExcursionsState(excursionCount: excursionCount));
      } catch (e) {
        AppMetrica.reportErrorWithGroup(
          'Tour level',
          message: e.toString(),
          errorDescription: AppMetricaErrorDescription(StackTrace.current),
        );
      }
    }
  }
}
