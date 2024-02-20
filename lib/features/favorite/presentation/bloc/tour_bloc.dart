import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repositories/service/service.dart';

import 'tour_event.dart';
import 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {

  TourBloc() : super(TourInitial()) {
    on<TourEvent>((event, emit) async {
      if (event is TourRequested) {
        await _tourRequested(event, emit);
      }
    },
    );
  }

  Future<void> _tourRequested(
      TourRequested event, Emitter<TourState> emit) async {
    emit(TourLoadInProgress());
    try {
      final List<Tour> tours = await TourService
          .getTourList(lon: event.lon, lat: event.lat);
      emit(TourListLoadedSuccess(tourList: tours));
    } catch (_) {
      emit(const TourLoadFailure(errorMsg: 'Error in weather request.'));
    }
  }
}