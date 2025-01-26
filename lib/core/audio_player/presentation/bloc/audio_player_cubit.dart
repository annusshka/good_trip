import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/audio_player/data/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/data/media_state.dart';
import 'package:good_trip/core/audio_player/data/position_data.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:rxdart/rxdart.dart';

import 'audio_player.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayerHandler audioPlayerHandler;
  final AudioHandler audioHandler;

  AudioPlayerCubit({
    required this.audioPlayerHandler,
    required this.audioHandler,
  }) : super(AudioPlayerInitial());

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MediaState> get mediaStateStream {
    return Rx.combineLatest2<MediaItem?, Duration, MediaState>(
      audioHandler.mediaItem,
      AudioService.position,
      (mediaItem, position) => MediaState(mediaItem, position),
    );
  }

  Future<void> loadExcursion({required AudioExcursion excursion}) async {
    emit(AudioPlayerIsLoading());
    try {
      await audioPlayerHandler.loadAudio(excursion);
      // final item = MediaItem(id: url, title: url);
      // audioPlayerHandler.addQueueItem(item);
      emit(AudioPlayerLoadSuccess());
    } catch (e) {
      emit(AudioPlayerLoadFailure(errorMsg: e.toString()));
    }
  }

  Stream<Duration> get bufferedPositionStream =>
      audioPlayerHandler.playbackState
          .map((state) => state.bufferedPosition)
          .distinct();

  Stream<Duration?> get durationStream =>
      audioPlayerHandler.mediaItem.map((item) => item?.duration).distinct();

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        AudioService.position,
        bufferedPositionStream,
        durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  Future<void> loadTour({
    required List<AudioExcursion> excursionList,
    required String tourName,
  }) async {
    emit(AudioPlayerIsLoading());
    try {
      await audioPlayerHandler.loadPlaylist(excursionList, tourName);
      // for (final AudioExcursion excursion in excursionList) {
      //   final item =
      //       MediaItem(id: excursion.audioUrl, title: excursion.audioUrl);
      //   audioPlayerHandler.addQueueItem(item);
      // }
      emit(AudioPlayerLoadSuccess());
    } catch (e) {
      emit(AudioPlayerLoadFailure(errorMsg: e.toString()));
    }
  }
}
