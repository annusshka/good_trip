import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler implements AudioHandler {
  final BehaviorSubject<Map<AudioSource, MediaItem>> mediaItemMap = BehaviorSubject.seeded({});
  final BehaviorSubject<List<MediaItem>> loadedPlaylist = BehaviorSubject.seeded(<MediaItem>[]);
  final BehaviorSubject<String> actualAlbum = BehaviorSubject.seeded('');
  final BehaviorSubject<String> loadedAlbum = BehaviorSubject.seeded('');

  final AudioPlayer player;
  final actualPlaylist = ConcatenatingAudioSource(children: [], useLazyPreparation: false);

  late final StreamSubscription _playbackEventSubscription;
  late final StreamSubscription _shuffleModeEnabledSubscription;
  late final StreamSubscription _processingStateSubscription;
  late final StreamSubscription _durationSubscription;
  late final StreamSubscription _mediaItemSubscription;

  /// Поток актуальной последовательности аудиозаписей из just_audio
  Stream<List<IndexedAudioSource>> get effectiveSequence => player.sequenceStream.map((sequence) => sequence ?? []);

  Stream<int?> get currentIndex =>
      actualAlbum.valueOrNull == loadedAlbum.valueOrNull ? player.currentIndexStream : const Stream.empty();

  AudioPlayerHandler({
    required this.player,
  });

  Future<void> init() async {
    /// Устанавливает режим работы плеера при взаимодействии с другими плеерами
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    _mediaItemSubscription =
        Rx.combineLatest2<int?, List<MediaItem>, MediaItem?>(player.currentIndexStream, queue, (index, queue) {
      return (index != null && index < queue.length) ? queue[index] : null;
    }).whereType<MediaItem>().distinct().listen(mediaItem.add);

    _playbackEventSubscription = player.playbackEventStream.listen(_broadcastState);
    _shuffleModeEnabledSubscription =
        player.shuffleModeEnabledStream.listen((enabled) => _broadcastState(player.playbackEvent));

    /// Завершение плейлиста
    _processingStateSubscription = player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        stop();
        player.seek(Duration.zero, index: 0);
        logPlaylistState();
      }
    });

    effectiveSequence
        .map(
          (sequence) => sequence
              .map(
                (source) => mediaItemMap.valueOrNull?[source] ?? const MediaItem(id: '-1', title: ''),
              )
              .toList(),
        )
        .pipe(queue);

    _durationSubscription = player.durationStream.listen((duration) {
      final index = player.currentIndex;
      final actualQueue = queue.value;
      if (index == null || actualQueue.isEmpty) {
        mediaItem.add(null);
        return;
      }
      final oldMediaItem = actualQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      mediaItem.add(newMediaItem);
    });
  }

  AudioSource _itemToSource(MediaItem mediaItem) {
    late final audioSource = AudioSource.uri(Uri.parse(mediaItem.id));
    mediaItemMap.valueOrNull?[audioSource] = mediaItem;
    return audioSource;
  }

  List<AudioSource> _itemsToSources(List<MediaItem> mediaItems) => mediaItems.map(_itemToSource).toList();

  void loadPlaylist(
    List<MediaItem> excursions,
    String album,
  ) {
    loadedPlaylist.add(excursions);
    loadedAlbum.add(album);
  }

  Future<void> startNewPlaylist({int? initialIndex}) async {
    await updateQueue(loadedPlaylist.valueOrNull ?? []);
    actualAlbum.add(loadedAlbum.valueOrNull ?? '');
    try {
      logPlaylistState();
      await player.setAudioSource(actualPlaylist, initialIndex: initialIndex ?? 0);
      logPlaylistState();
    } on PlayerException catch (e) {
      debugPrint('Error loading audio source: $e');
    }
  }

  Future<void> playNewAudio(int index) async {
    final _actualAlbum = actualAlbum.valueOrNull ?? '';
    final _loadedAlbum = loadedAlbum.valueOrNull ?? '';

    if (!(_actualAlbum.isNotEmpty && _actualAlbum == _loadedAlbum)) {
      await startNewPlaylist();
    }
    skipToQueueItem(index);
    play();
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    await actualPlaylist.add(_itemToSource(mediaItem));
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    await actualPlaylist.addAll(_itemsToSources(mediaItems));
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {
    await actualPlaylist.insert(index, _itemToSource(mediaItem));
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    logPlaylistState();
    if (actualPlaylist.children.isNotEmpty) {
      try {
        actualPlaylist.children.clear();
      } catch (_) {
        actualPlaylist.addAll([]);
      } finally {
        actualPlaylist.children.addAll(_itemsToSources(queue));
      }
    } else {
      await actualPlaylist.addAll(_itemsToSources(queue));
    }
  }

  void logPlaylistState() {
    debugPrint('actualPlaylist state: ${actualPlaylist.toString()}');
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
    final sequence = player.sequence;
    if (index > -1 && sequence != null && index < sequence.length) {
      mediaItemMap.valueOrNull?[sequence[index]] = mediaItem;
    }
  }

  Future<void> moveQueueItem(int currentIndex, int newIndex) async {
    await actualPlaylist.move(currentIndex, newIndex);
  }

  @override
  Future<void> skipToNext() => player.seekToNext();

  @override
  Future<void> skipToPrevious() => player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= actualPlaylist.children.length) return;
    player.seek(Duration.zero, index: index);
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> seek(Duration position) => player.seek(position);

  @override
  Future<void> stop() async {
    await player.stop();
    await playbackState.firstWhere((state) => state.processingState == AudioProcessingState.idle);
  }

  void clearQueue() {
    logPlaylistState();
    mediaItemMap.valueOrNull?.clear();
    actualPlaylist.clear();
    queue.valueOrNull?.removeRange(0, queue.valueOrNull?.length ?? 0);
  }

  void _broadcastState(PlaybackEvent event) {
    final playing = player.playing;
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 2],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[player.processingState]!,
        playing: playing,
        updatePosition: player.position,
        bufferedPosition: player.bufferedPosition,
        speed: player.speed,
        queueIndex: event.currentIndex,
      ),
    );
  }

  void dispose() {
    mediaItemMap.close();
    queue.close();
    loadedPlaylist.close();
    actualAlbum.close();
    loadedAlbum.close();

    _playbackEventSubscription.cancel();
    _shuffleModeEnabledSubscription.cancel();
    _processingStateSubscription.cancel();
    _durationSubscription.cancel();
    _mediaItemSubscription.cancel();
    player.dispose();
  }
}
