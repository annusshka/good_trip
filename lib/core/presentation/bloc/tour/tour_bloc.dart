import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/service/service.dart';
import 'tour.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  TourBloc() : super(TourInitial()) {
    on<TourEvent>(
      (event, emit) async {
        if (event is TourLikeRequested) {
          await _requestTourLike(event, emit);
        }
        if (event is TourSaveRequested) {
          //await _requestTourSave(event, emit);
        }
      },
    );
  }

  Future<void> _requestTourLike(
      TourLikeRequested event, Emitter<TourState> emit) async {
    emit(TourLoadInProgress());
    try {
      await TourService().likeTour(event.id);
      emit(TourLikedSuccess());
    } catch (e) {
      emit(TourListLoadFailure(errorMsg: e.toString()));
    }
  }

  /*
  Future<void> _requestTourSave(
      TourSaveRequested event, Emitter<TourState> emit) async {
    emit(TourLoadInProgress());
    try {
      await TourService().saveTour(event.tour.name);
      emit(TourLoadSuccess());
    } catch (e) {
      emit(TourListLoadFailure(errorMsg: e.toString()));
    }
  }*/
}
