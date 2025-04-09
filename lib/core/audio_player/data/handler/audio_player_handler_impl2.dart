import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler2.dart';
import 'package:good_trip/core/audio_player/data/handler/queue_state2.dart';
import 'package:good_trip/core/audio_player/data/media_library.dart';
import 'package:good_trip/core/audio_player/data/queue_state.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

/// Реализация [AudioPlayerHandler].
///
/// Этот обработчик поддерживается проигрывателем just_audio.
/// Последовательность действий проигрывателя отображается в очереди
/// обработчика, а состояние проигрывателя отображается в состоянии обработчика.
class AudioPlayerHandlerImpl2 extends BaseAudioHandler with SeekHandler implements AudioPlayerHandler2 {
  final BehaviorSubject<List<MediaItem>> loadedPlaylist = BehaviorSubject.seeded(<MediaItem>[]);
  final BehaviorSubject<String> actualAlbum = BehaviorSubject.seeded('');
  final BehaviorSubject<String> loadedAlbum = BehaviorSubject.seeded('');

  final _player = AudioPlayer();
  final _actualPlaylist = ConcatenatingAudioSource(children: []);
  final _mediaItemExpando = Expando<MediaItem>();

  /// Поток актуальной последовательности аудиозаписей из just_audio
  Stream<List<IndexedAudioSource>> get _effectiveSequence => _player.sequenceStream.map((sequence) => sequence ?? []);

  /// Поток, сообщающий о совокупном состоянии текущей очереди и текущего
  /// мультимедийного элемента в этой очереди.
  @override
  Stream<QueueState2> get queueState => Rx.combineLatest2<List<MediaItem>, PlaybackState, QueueState2>(
      queue,
      playbackState,
      (queue, playbackState) => QueueState2(
            queue,
            playbackState.queueIndex,
          ));

  Stream<int?> get currentIndex =>
      actualAlbum.valueOrNull == loadedAlbum.valueOrNull ? _player.currentIndexStream : const Stream.empty();

  AudioPlayerHandlerImpl2() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    // Broadcast media item changes.
    Rx.combineLatest2<int?, List<MediaItem>, MediaItem?>(_player.currentIndexStream, queue, (index, queue) {
      return (index != null && index < queue.length) ? queue[index] : null;
    }).whereType<MediaItem>().distinct().listen(mediaItem.add);

    // Propagate all events from the audio player to AudioService clients.
    _player.playbackEventStream.listen(_broadcastState);
    _player.shuffleModeEnabledStream.listen((enabled) => _broadcastState(_player.playbackEvent));
    // In this example, the service stops when reaching the end.
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        stop();
        _player.seek(Duration.zero, index: 0);
      }
    });
    // Broadcast the current queue.
    _effectiveSequence.map((sequence) => sequence.map((source) => _mediaItemExpando[source]!).toList()).pipe(queue);
    // Load the playlist.
    if (_actualPlaylist.length != 0) {
      _actualPlaylist.addAll(queue.value.map(_itemToSource).toList());
      await _player.setAudioSource(_actualPlaylist);
    }
  }

  AudioSource _itemToSource(MediaItem mediaItem) {
    final audioSource = AudioSource.uri(Uri.parse(mediaItem.id));
    _mediaItemExpando[audioSource] = mediaItem;
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

  Future<void> startNewPlaylist() async {
    await updateQueue(loadedPlaylist.valueOrNull ?? []);
    actualAlbum.add(loadedAlbum.valueOrNull ?? '');
    await _player.setAudioSource(_actualPlaylist);
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
    await _actualPlaylist.add(_itemToSource(mediaItem));
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    await _actualPlaylist.addAll(_itemsToSources(mediaItems));
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {
    await _actualPlaylist.insert(index, _itemToSource(mediaItem));
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    await _actualPlaylist.clear();
    await _actualPlaylist.addAll(_itemsToSources(queue));
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
    _mediaItemExpando[_player.sequence![index]] = mediaItem;
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {
    final index = queue.value.indexOf(mediaItem);
    await _actualPlaylist.removeAt(index);
  }

  Future<void> moveQueueItem(int currentIndex, int newIndex) async {
    await _actualPlaylist.move(currentIndex, newIndex);
  }

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= _actualPlaylist.children.length) return;
    _player.seek(Duration.zero, index: index);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await playbackState.firstWhere((state) => state.processingState == AudioProcessingState.idle);
  }

  /// Broadcasts the current state to all clients.
  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    ));
  }

  void dispose() {
    loadedPlaylist.close();
    actualAlbum.close();
    loadedAlbum.close();
    loadedPlaylist.close();
  }
}
