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
      emit(TourLikedSuccess());
    } catch (e) {
      emit(TourListLoadFailure(errorMsg: e.toString()));
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
    }
  }
}
