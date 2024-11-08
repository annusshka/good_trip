import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'excursion_list.dart';

class ExcursionListBloc extends Bloc<ExcursionListEvent, ExcursionListState> {
  final IApiTourRepository excursionRepository;

  ExcursionListBloc({required this.excursionRepository}) : super(ExcursionListInitial()) {
    on<ExcursionListEvent>((event, emit) async {
      if (event is ExcursionListRequested) {
        await _requestExcursionList(event, emit);
      }
    },
    );
  }

  Future<void> _requestExcursionList(ExcursionListRequested event, Emitter<ExcursionListState> emit) async {
    emit(ExcursionListLoadInProgress());
    try {
      final List<Excursion> tourList = await excursionRepository.getExcursionList(
          lon: event.lon, lat: event.lat, limit: 10);
      emit(ExcursionListLoadSuccess(excursionList: tourList));
    } catch (e) {
      emit(ExcursionListLoadFailure(errorMsg: e.toString()));
    }
  }
}