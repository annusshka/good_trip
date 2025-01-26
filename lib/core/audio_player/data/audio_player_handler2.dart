import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler with QueueHandler {
  final audioPlayer = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(children: []);

  AudioPlayerHandler() {
    audioPlayer.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _loadEmptyPlaylist();
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      // setup and allow which control item in the control panel in the phone's lock screen
      controls: [
        MediaControl.skipToPrevious,
        MediaControl.rewind,
        if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
        MediaControl.skipToNext,
      ],
      // setup the action can be used, it will show the buttons in the phone's lock screen
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      // for android lock screen control buttons
      androidCompactActionIndices: const [0, 1, 3],
      // map the audio service processing state to just audio
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[audioPlayer.processingState]!,
      playing: audioPlayer.playing,
      // is playing status
      updatePosition: audioPlayer.position,
      // the current playing position
      bufferedPosition: audioPlayer.bufferedPosition,
      // the buffered position
      speed: audioPlayer.speed,
      // player speed
      queueIndex: event.currentIndex, // the index of the current queue
    );
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await audioPlayer.setAudioSource(_playlist);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addAudio({required String url}) async {
    try {
      final item = MediaItem(id: url, title: '1111');
      mediaItem.add(item);
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> play() => audioPlayer.play();

  @override
  Future<void> pause() => audioPlayer.pause();

  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  @override
  Future<void> stop() async {
    await audioPlayer.stop();
    await playbackState.firstWhere(
        (state) => state.processingState == AudioProcessingState.idle);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final audioSource = mediaItems.map(_createAudioSource);
    _playlist.addAll(audioSource.toList());

    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

// add the audio item into playlist and queue before playing it
  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    final audioSource = _createAudioSource(mediaItem);
    _playlist.add(audioSource);

    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    _playlist.removeAt(index);

    final newQueue = queue.value..removeAt(index);
    queue.add(newQueue);
  }

  @override
  Future<dynamic> customAction(String name,
      [Map<String, dynamic>? extras]) async {
    // set the custom action like adjusting the volume from the UI
    if (name == 'setVolume') {
      audioPlayer.setVolume(extras!['value']);
    }
  }

// create the just audio source from audio file
// we pass the audio file via mediaitem.id from UI
  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    debugPrint('add media item=========${mediaItem.id}');
    return AudioSource.uri(
      Uri.parse(mediaItem.id),
      tag: mediaItem,
    );
  }

  Duration? getTotalDuration() => audioPlayer.duration;

  Future<Duration?> resumeMediaItem(
      MediaItem item, Duration currentDuration) async {
    var index = _getIndex(item);
    await audioPlayer.seek(currentDuration, index: index);
    mediaItem.add(item.copyWith(duration: audioPlayer.duration));
    await audioPlayer.play();
    return audioPlayer.duration;
  }

// get the media item index in the playlist for seeking
// so that we can resume it
  int _getIndex(MediaItem item) {
    int targetIndex = -1;
    final audioSource = _createAudioSource(item);
    for (int i = 0; i < _playlist.length; i++) {
      final currentItem = _playlist.children[i] as UriAudioSource;
      // print('current item');
      if (currentItem.uri.path == audioSource.uri.path) {
        //print('{audioSource.uri.path} index:i');
        targetIndex = i;
        break;
      }
    }
    // print('get index:$targetIndex');
    return targetIndex;
  }

  Future<bool> hasMediaItem(MediaItem item) async {
    var index = -1;
    if (_playlist.sequence.isNotEmpty) {
      index = _getIndex(item);
    }
    return index >= 0;
  }
}
