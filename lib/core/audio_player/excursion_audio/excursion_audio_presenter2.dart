import 'package:audio_service/audio_service.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/data/position_data.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class ExcursionAudioPresenter2 {
  final int? index;
  final String? tourName;
  final AudioExcursion excursion;
  final AudioPlayerHandler audioPlayerHandler;
  final AudioPlayer audioPlayer;

  ExcursionAudioPresenter2({
    this.index,
    this.tourName,
    required this.excursion,
    required this.audioPlayerHandler,
    required this.audioPlayer,
  });

  final BehaviorSubject<bool> isActualAudio = BehaviorSubject.seeded(false);
  final BehaviorSubject<MediaItem?> mediaItem = BehaviorSubject();
  final BehaviorSubject<PlaybackState> playbackState = BehaviorSubject();

  Stream<Duration> get bufferedPositionStream =>
      audioPlayerHandler.playbackState.map((state) => state.bufferedPosition).distinct();

  Stream<Duration?> get durationStream => mediaItem.map((item) => item?.duration).distinct();

  Stream<PositionData> get positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
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
    mediaItem.add(item);
    audioPlayerHandler.loadPlaylist([item], tourName ?? excursion.name);

    audioPlayerHandler.loadedPlaylist.listen((loadedPlayList) {
      mediaItem.add(loadedPlayList[index ?? 0]);
      final _actualAlbum = audioPlayerHandler.actualAlbum.valueOrNull ?? '';
      if (_actualAlbum == (tourName ?? excursion.name)) {
        isActualAudio.add(true);
      }
    });
  }

  Future<MediaItem> excursionsToMediaItems(AudioExcursion excursion) async {
    final audioDuration = await audioPlayer.setUrl(excursion.audioUrl);
    return MediaItem(
      id: excursion.audioUrl,
      title: excursion.name,
      album: tourName ?? excursion.name,
      duration: audioDuration,
      artUri: Uri.tryParse(excursion.imageUrl ?? ''),
    );
  }

  Future<void> playNewAudio() async {
    isActualAudio.add(true);
    await audioPlayerHandler.playNewAudio(index ?? 0);
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
