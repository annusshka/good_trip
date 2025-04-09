import 'package:audio_service/audio_service.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler_impl.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler_impl2.dart';
import 'package:good_trip/core/audio_player/data/position_data.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class ExcursionAudioPresenter2 {
  final int? index;
  final String? tourName;
  final AudioExcursion excursion;
  final AudioPlayerHandlerImpl2 audioPlayerHandler;

  ExcursionAudioPresenter2({
    this.index,
    this.tourName,
    required this.excursion,
    required this.audioPlayerHandler,
  });

  final BehaviorSubject<bool> isActualAudio = BehaviorSubject.seeded(false);
  late final BehaviorSubject<MediaItem?> mediaItem = BehaviorSubject();
  late final BehaviorSubject<PlaybackState> playbackState = BehaviorSubject();

  Stream<Duration> get bufferedPositionStream =>
      audioPlayerHandler.playbackState
          .map((state) => state.bufferedPosition)
          .distinct();

  Stream<Duration?> get durationStream =>
      mediaItem.map((item) => item?.duration).distinct();

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

  Future<void> init() async {
    final MediaItem item = await excursionsToMediaItems(excursion);
    audioPlayerHandler.loadPlaylist([item], tourName ?? excursion.name);

    audioPlayerHandler.loadedPlaylist.listen((loadedPlayList) {
      mediaItem.add(loadedPlayList[0]);
    });
  }

  Future<MediaItem> excursionsToMediaItems(
      AudioExcursion excursion,
      ) async {
    final audioDuration = await AudioPlayer().setUrl(excursion.audioUrl);
    return MediaItem(
      id: excursion.audioUrl,
      title: excursion.name,
      album: tourName ?? excursion.name,
      duration: audioDuration,
      artUri: Uri.tryParse(excursion.imageUrl ?? ''),
    );
  }

  bool checkIndex(int? i) {
    return false;
  }

  Future<void> playNewAudio() async {
    isActualAudio.add(true);
    await audioPlayerHandler.playNewAudio(0);
  }

  void pause() {
    audioPlayerHandler.pause();
  }

  void dispose() {
    isActualAudio.close();
    mediaItem.close();
    playbackState.close();
  }
}