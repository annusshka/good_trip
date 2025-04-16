import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'audio_excursion_list.dart';

class AudioExcursionListBloc extends Bloc<AudioExcursionListEvent, AudioExcursionListState> {
  final IExcursionRepository excursionRepository;

  AudioExcursionListBloc({required this.excursionRepository}) : super(AudioExcursionListInitial()) {
    on<AudioExcursionListEvent>(
      (event, emit) async {
        if (event is AudioExcursionListRequested) {
          await _requestExcursionList(event, emit);
        }
      },
    );
  }

  Future<void> _requestExcursionList(
      AudioExcursionListRequested event, Emitter<AudioExcursionListState> emit) async {
    emit(AudioExcursionListLoadInProgress());
    try {
      final List<AudioExcursion> tourList = await excursionRepository.getAudioExcursions(
        city: event.city,
        lon: event.lon,
        lat: event.lat,
        offset: event.offset,
      );
      emit(AudioExcursionListLoadSuccess(tourList: tourList));
    } catch (e) {
      emit(AudioExcursionListLoadFailure(errorMsg: e.toString()));
      AppMetrica.reportErrorWithGroup(
        'AudioExcursion level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
