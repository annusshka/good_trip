import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
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
        } else if (event is TourListRequested) {
          await _requestTourList(event, emit);
        }
      },
    );
  }

  Future<void> _requestTourLike(TourLikeRequested event, Emitter<TourState> emit) async {
    emit(TourLoadInProgress());
    try {
      await tourRepository.likeTour(id: event.id, isLiked: event.isLiked);
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

  Future<void> _requestTourSave(TourSaveRequested event, Emitter<TourState> emit) async {
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

  Future<void> _requestTourList(TourListRequested event, Emitter<TourState> emit) async {
    emit(TourLoadInProgress());
    try {
      final List<Tour> tourList = await tourRepository.getTours(
        city: event.city,
        lon: event.lon,
        lat: event.lat,
        offset: event.offset,
      );
      emit(TourListLoadSuccess(tourList: tourList));
    } catch (e) {
      emit(TourListLoadFailure(errorMsg: e.toString()));
      AppMetrica.reportErrorWithGroup(
        'AudioExcursion level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
