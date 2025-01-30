import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'tour.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  final ITourRepository tourRepository;

  TourBloc({required this.tourRepository}) : super(TourInitial()) {
    on<TourEvent>(
      (event, emit) async {
        if (event is TourLikeRequested) {
          await _requestTourLike(event, emit);
        } else if (event is TourSaveRequested) {
          await _requestTourSave(event, emit);
        }
      },
    );
  }

  Future<void> _requestTourLike(
      TourLikeRequested event, Emitter<TourState> emit) async {
    emit(TourLoadInProgress());
    try {
      /// TODO: add user data layer
      final userId = 1;
      await tourRepository.likeTour(
        userId: userId,
        id: event.id,
      );
      Map<String, String> attributesMap = {'tour_id': event.id};
      AppMetrica.reportEventWithMap('tour_like', attributesMap);
      emit(TourLikedSuccess());
    } catch (e) {
      emit(TourListLoadFailure(errorMsg: e.toString()));
      AppMetrica.reportErrorWithGroup(
        'Tour level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  Future<void> _requestTourSave(
      TourSaveRequested event, Emitter<TourState> emit) async {
    emit(TourLoadInProgress());
    try {
      //await excursionRepository.saveExcursion(event.tour);
      emit(TourLoadSuccess());
    } catch (e) {
      emit(TourListLoadFailure(errorMsg: e.toString()));
      AppMetrica.reportErrorWithGroup(
        'Tour level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
