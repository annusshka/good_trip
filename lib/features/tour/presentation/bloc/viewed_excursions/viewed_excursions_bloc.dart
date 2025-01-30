import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'viewed_excursions.dart';

class ViewedExcursionsBloc
    extends Bloc<ViewedExcursionsEvent, ViewedExcursionsState> {
  final ITourRepository tourRepository;

  ViewedExcursionsBloc({required this.tourRepository})
      : super(ViewedExcursionsInitial()) {
    on<ViewedExcursionsEvent>(
      (event, emit) async {
        if (event is ViewedExcursionRequested) {
          await _requestViewedExcursion(event, emit);
        } else if (event is ViewExcursionRequested) {
          await _requestViewExcursion(event, emit);
        }
      },
    );
  }

  Future<void> _requestViewedExcursion(ViewedExcursionRequested event,
      Emitter<ViewedExcursionsState> emit) async {
    emit(ViewedExcursionsLoadInProgress());
    try {
      final viewedExcursions = await tourRepository.getViewedExcursionCount(
        tourId: event.tourId,
      );
      emit(LoadViewedExcursionsSuccess(excursionCount: viewedExcursions));
    } catch (e) {
      emit(ViewedExcursionsLoadFailure(errorMsg: e.toString()));
      AppMetrica.reportErrorWithGroup(
        'Tour level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  Future<void> _requestViewExcursion(
      ViewExcursionRequested event, Emitter<ViewedExcursionsState> emit) async {
    if (event.excursionCount > event.actualCount) {
      emit(ViewedExcursionsLoadInProgress());
      try {
        await tourRepository.viewExcursions(
          tourId: event.tourId,
          excursionCount: event.excursionCount,
        );
        Map<String, String> attributesMap = {
          'tour': event.tourId,
          'view_count': event.excursionCount.toString(),
        };
        AppMetrica.reportEventWithMap('view_excursion', attributesMap);
        emit(LoadViewedExcursionsSuccess(excursionCount: event.excursionCount));
      } catch (e) {
        emit(ViewedExcursionsLoadFailure(errorMsg: e.toString()));
        AppMetrica.reportErrorWithGroup(
          'Tour level',
          message: e.toString(),
          errorDescription: AppMetricaErrorDescription(StackTrace.current),
        );
      }
    }
  }
}
