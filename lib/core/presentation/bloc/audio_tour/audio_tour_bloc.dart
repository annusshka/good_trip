import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/models.dart';
import '../../../domain/service/service.dart';
import 'audio_tour.dart';

class AudioTourBloc extends Bloc<AudioTourEvent, AudioTourState> {
  AudioTourBloc() : super(AudioTourInitial()) {
    on<AudioTourEvent>(
      (event, emit) async {
        if (event is AudioTourRequested) {
          await _requestTourList(event, emit);
        }
      },
    );
  }

  Future<void> _requestTourList(
      AudioTourRequested event, Emitter<AudioTourState> emit) async {
    emit(AudioTourLoadInProgress());
    try {
      final List<AudioTour> tourList = await TourService().getAudioTourList(
          city: event.city,
          lon: event.lon,
          lat: event.lat,
          offset: event.offset);
      emit(AudioTourLoadSuccess(tourList: tourList));
    } catch (e) {
      emit(AudioTourLoadFailure(errorMsg: e.toString()));
    }
  }
}
