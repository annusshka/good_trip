import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'tour_create_list.dart';

class TourCreateListBloc
    extends Bloc<TourCreateListEvent, TourCreateListState> {
  final ITourRepository tourRepository;

  TourCreateListBloc({required this.tourRepository}) : super(TourCreateListInitial()) {
    on<TourCreateListEvent>(
      (event, emit) async {
        if (event is TourCreateListRequested) {
          await _tourCreatedListRequested(event, emit);
        } else if (event is TourListCreateByActualUserRequested) {
          await _tourListCreatedByActualUserRequested(event, emit);
        }
      },
    );
  }

  Future<void> _tourCreatedListRequested(
      TourCreateListRequested event, Emitter<TourCreateListState> emit) async {
    emit(TourCreateListLoadInProgress());
    try {
      final List<AudioTour> tours =
          await tourRepository.getCreatedTourListByAdmin(offset: event.offset);
      emit(TourCreateListLoadedSuccess(tourList: tours));
    } catch (_) {
      emit(const TourCreateListLoadFailure(
          errorMsg: 'Error in created tours request.'));
    }
  }

  Future<void> _tourListCreatedByActualUserRequested(
      TourListCreateByActualUserRequested event,
      Emitter<TourCreateListState> emit) async {
    emit(TourCreateListLoadInProgress());
    try {
      ///TODO: add user data layer
      const userId = 1;
      final List<AudioTour> tours =
          await tourRepository.getCreatedTourListByUserId(
        offset: event.offset,
        userId: userId,
      );
      emit(TourCreateListLoadedSuccess(tourList: tours));
    } catch (_) {
      emit(const TourCreateListLoadFailure(
          errorMsg: 'Error in created tours request.'));
    }
  }
}
