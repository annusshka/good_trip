import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/domain/models/models.dart';

import '../../../../core/domain/service/service.dart';
import 'tour_create_list.dart';

class TourCreateListBloc extends Bloc<TourCreateListEvent, TourCreateListState> {

  TourCreateListBloc() : super(TourCreateListInitial()) {
    on<TourCreateListEvent>((event, emit) async {
      if (event is TourCreateListRequested) {
        await _tourCreatedListRequested(event, emit);
      }
      if (event is TourListCreateByActualUserRequested) {
        await _tourListCreatedByActualUserRequested(event, emit);
      }
    },
    );
  }

  Future<void> _tourCreatedListRequested(
      TourCreateListRequested event, Emitter<TourCreateListState> emit) async {
    emit(TourCreateListLoadInProgress());
    try {
      final List<AudioTour> tours = await TourService().getCreatedTourListByUserId(offset: event.offset);
      emit(TourCreateListLoadedSuccess(tourList: tours));
    } catch (_) {
      emit(const TourCreateListLoadFailure(errorMsg: 'Error in weather request.'));
    }
  }

  Future<void> _tourListCreatedByActualUserRequested(
      TourListCreateByActualUserRequested event, Emitter<TourCreateListState> emit) async {
    emit(TourCreateListLoadInProgress());
    try {
      final List<AudioTour> tours = await TourService().getCreatedTourListByUserId(offset: event.offset);
      emit(TourCreateListLoadedSuccess(tourList: tours));
    } catch (_) {
      emit(const TourCreateListLoadFailure(errorMsg: 'Error in weather request.'));
    }
  }
}