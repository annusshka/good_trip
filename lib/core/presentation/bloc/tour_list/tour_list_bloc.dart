import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/tour/tour.dart';
import '../../../domain/service/service.dart';
import 'tour_list.dart';

class TourListBloc extends Bloc<TourListEvent, TourListState> {

  TourListBloc() : super(TourListInitial()) {
    on<TourListEvent>((event, emit) async {
      if (event is TourListRequested) {
        await _requestTourList(event, emit);
      }
    },
    );
  }

  Future<void> _requestTourList(TourListRequested event, Emitter<TourListState> emit) async {
    emit(TourListLoadInProgress());
    try {
      final List<Tour> tourList = await TourService.getTourList(
          lon: event.lon, lat: event.lat, limit: 10);
      emit(TourListLoadSuccess(tourList: tourList));
    } catch (e) {
      emit(TourListLoadFailure(errorMsg: e.toString()));
    }
  }
}