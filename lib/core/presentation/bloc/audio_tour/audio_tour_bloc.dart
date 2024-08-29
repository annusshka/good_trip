import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'audio_tour.dart';

class AudioTourBloc extends Bloc<AudioTourEvent, AudioTourState> {
  final ITourRepository tourRepository;

  AudioTourBloc({required this.tourRepository}) : super(AudioTourInitial()) {
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
      /// TODO: data layer for UserData
      final userId = 1;
      final List<AudioTour> tourList = await tourRepository.getAudioTours(
        city: event.city,
        lon: event.lon,
        lat: event.lat,
        offset: event.offset,
        userId: userId,
      );
      emit(AudioTourLoadSuccess(tourList: tourList));
    } catch (e) {
      emit(AudioTourLoadFailure(errorMsg: e.toString()));
    }
  }
}
