import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'audio_excursion.dart';

class AudioExcursionBloc extends Bloc<AudioExcursionEvent, AudioExcursionState> {
  final IExcursionRepository excursionRepository;

  AudioExcursionBloc({required this.excursionRepository}) : super(AudioExcursionInitial()) {
    on<AudioExcursionEvent>(
      (event, emit) async {
        if (event is AudioExcursionRequested) {
          await _requestExcursionList(event, emit);
        }
      },
    );
  }

  Future<void> _requestExcursionList(
      AudioExcursionRequested event, Emitter<AudioExcursionState> emit) async {
    emit(AudioExcursionLoadInProgress());
    try {
      final List<AudioExcursion> tourList = await excursionRepository.getAudioExcursions(
        city: event.city,
        lon: event.lon,
        lat: event.lat,
        offset: event.offset,
      );
      emit(AudioExcursionLoadSuccess(tourList: tourList));
    } catch (e) {
      emit(AudioExcursionLoadFailure(errorMsg: e.toString()));
      AppMetrica.reportErrorWithGroup(
        'AudioExcursion level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
