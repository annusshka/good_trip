import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:audio_service/audio_service.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/data/position_data.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class ExcursionListPresenter {
  final String loadedAlbum;
  final List<AudioExcursion> excursionList;
  final AudioPlayerHandler audioPlayerHandler;

  ExcursionListPresenter({
    required this.loadedAlbum,
    required this.excursionList,
    required this.audioPlayerHandler,
  });

  final BehaviorSubject<bool> isActualPlaylist = BehaviorSubject.seeded(false);
  final BehaviorSubject<List<MediaItem>?> mediaItems = BehaviorSubject();
  final BehaviorSubject<PlaybackState> playbackState = BehaviorSubject();
  final BehaviorSubject<int?> actualIndex = BehaviorSubject();

  Stream<Duration> get bufferedPositionStream =>
      audioPlayerHandler.playbackState.map((state) => state.bufferedPosition).distinct();

  Stream<PositionData> get positionDataStream => Rx.combineLatest2<Duration, Duration, PositionData>(
        AudioService.position,
        bufferedPositionStream,
        PositionData.new,
      );

  Future<void> init() async {
    final List<MediaItem> mediaItemList = await excursionsToMediaItems(excursionList, loadedAlbum);
    mediaItems.add(mediaItemList);
    // audioPlayerHandler.loadPlaylist(mediaItems, tourName);
    AppMetrica.reportEvent('load audio_tour $loadedAlbum');
    audioPlayerHandler.actualAlbum.listen((value) {
      isActualPlaylist.add(loadedAlbum == value);
    });

    audioPlayerHandler.currentIndex.listen((value) {
      final isPlaying = isActualPlaylist.valueOrNull ?? false;
      if (isPlaying) {
        actualIndex.add(value);
      } else {
        actualIndex.add(null);
      }
    });
  }

  Future<List<MediaItem>> excursionsToMediaItems(List<AudioExcursion> excursions, String tourName) async {
    List<MediaItem> items = [];
    for (final AudioExcursion excursion in excursions) {
      try {
        final audioDuration = await AudioPlayer().setUrl(excursion.audioUrl);
        final item = MediaItem(
          id: excursion.audioUrl,
          title: excursion.name,
          album: tourName,
          duration: audioDuration,
          artUri: Uri.tryParse(excursion.imageUrl ?? ''),
        );
        items.add(item);
      } catch (_) {
        final item = MediaItem(
          id: '',
          title: excursion.name,
          album: tourName,
          duration: Duration.zero,
          artUri: Uri.tryParse(excursion.imageUrl ?? ''),
        );
        items.add(item);
      }
    }
    return items;
  }

  Future<void> startNewPlaylist(int index) async {
    isActualPlaylist.add(true);
    final mediaItemList = mediaItems.valueOrNull ?? [];
    await audioPlayerHandler.startNewPlaylist(
      loadedPlaylist: mediaItemList,
      loadedAlbum: loadedAlbum,
      initialIndex: index,
    );
    actualIndex.add(index);
  }

  Future<void> playNewAudio(int index) async {
    await audioPlayerHandler.playNewAudio(index);
  }

  Future<void> play() async {
    await audioPlayerHandler.play();
  }

  void pause() {
    audioPlayerHandler.pause();
  }

  void dispose() {
    isActualPlaylist.close();
    mediaItems.close();
    playbackState.close();
    actualIndex.close();
  }
}
