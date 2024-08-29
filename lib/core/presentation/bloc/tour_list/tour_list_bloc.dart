import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'tour_list.dart';

class TourListBloc extends Bloc<TourListEvent, TourListState> {
  final IApiTourRepository tourRepository;

  TourListBloc({required this.tourRepository}) : super(TourListInitial()) {
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
      final List<Tour> tourList = await tourRepository.getTourList(
          lon: event.lon, lat: event.lat, limit: 10);
      emit(TourListLoadSuccess(tourList: tourList));
    } catch (e) {
      emit(TourListLoadFailure(errorMsg: e.toString()));
    }
  }
}