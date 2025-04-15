import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'tour_create_list.dart';

class TourCreateListBloc
    extends Bloc<TourCreateListEvent, TourCreateListState> {
  final ITourRepository tourRepository;

  TourCreateListBloc({required this.tourRepository})
      : super(TourCreateListInitial()) {
    on<TourCreateListEvent>(
      (event, emit) async {
        if (event is TourCreateListRequested) {
          await _tourCreatedListRequested(event, emit);
        } else if (event is ToursCreateByActualUserRequested) {
          await _toursCreatedByActualUserRequested(event, emit);
        }
      },
    );
  }

  Future<void> _tourCreatedListRequested(
      TourCreateListRequested event, Emitter<TourCreateListState> emit) async {
    emit(TourCreateListLoadInProgress());
    try {
      final List<Tour> tours =
          await tourRepository.getCreatedToursByAdmin(offset: event.offset);
      AppMetrica.reportEvent('load_created_tours');
      emit(TourCreateListLoadedSuccess(tourList: tours));
    } catch (e) {
      emit(
        const TourCreateListLoadFailure(
            errorMsg: 'Error in created tours request.'),
      );
      AppMetrica.reportErrorWithGroup(
        'TourCreate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  Future<void> _toursCreatedByActualUserRequested(
      ToursCreateByActualUserRequested event,
      Emitter<TourCreateListState> emit) async {
    emit(TourCreateListLoadInProgress());
    try {
      final List<Tour> tours = await tourRepository.getCreatedToursByUserId(
        offset: event.offset,
      );
      AppMetrica.reportEvent('create_tour');
      emit(TourCreateListLoadedSuccess(tourList: tours));
    } catch (e) {
      emit(
        const TourCreateListLoadFailure(
            errorMsg: 'Error in created tours request.'),
      );
      AppMetrica.reportErrorWithGroup(
        'TourCreate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
