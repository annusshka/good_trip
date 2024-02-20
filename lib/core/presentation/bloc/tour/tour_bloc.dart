import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour_state.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/service/service.dart';
import 'tour_event.dart';

class TourBloc extends Bloc<TourEvent, TourState> {

  TourBloc() : super(TourInitial()) {
    on<TourEvent>((event, emit) async {
      if (event is TourRequested) {
        await _requestTourList(event, emit);
      }
    },
    );
  }

  Future<void> _requestTourList(TourRequested event, Emitter<TourState> emit) async {
    emit(TourLoadInProgress());
    final List<Tour> tourList = await TourService.getTourList(
        lon: event.lon, lat: event.lat, limit: 10);
    emit(TourLoadSuccess(tourList: tourList));
  }
}