import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'tour_list.dart';

class TourListBloc extends Bloc<TourListEvent, TourListState> {
  final ITourRepository tourRepository;

  TourListBloc({required this.tourRepository}) : super(TourListInitial()) {
    on<TourListEvent>(
      (event, emit) async {
        if (event is TourLikeRequested) {
          await _requestTourLike(event, emit);
        } else if (event is TourListRequested) {
          await _requestTourList(event, emit);
        }
      },
    );
  }

  Future<void> _requestTourLike(TourLikeRequested event, Emitter<TourListState> emit) async {
    emit(TourLikeInProgress());
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

  Future<void> _requestTourList(TourListRequested event, Emitter<TourListState> emit) async {
    emit(TourListLoadInProgress());
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
