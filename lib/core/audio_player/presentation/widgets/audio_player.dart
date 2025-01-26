import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/audio_player/data/media_state.dart';
import 'package:good_trip/core/audio_player/presentation/bloc/audio_player.dart';
import 'package:good_trip/core/audio_player/presentation/widgets/seek_bar.dart';
import 'package:good_trip/core/data/models/audio_excursion/audio_excursion.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({
    super.key,
    required this.excursion,
  });

  final AudioExcursion excursion;

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AudioPlayerCubit>();
    final _audioHandler = cubit.audioHandler;

    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
        builder: (context, state) {
      if (state is AudioPlayerInitial) {
        cubit.audioPlayerHandler.loadAudio(widget.excursion);
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show media item title
          StreamBuilder<MediaItem?>(
            stream: _audioHandler.mediaItem,
            builder: (context, snapshot) {
              final mediaItem = snapshot.data;
              return Text(mediaItem?.title ?? '');
            },
          ),
          // Play/pause/stop buttons.
          StreamBuilder<bool>(
            stream: _audioHandler.playbackState
                .map((state) => state.playing)
                .distinct(),
            builder: (context, snapshot) {
              final playing = snapshot.data ?? false;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _button(Icons.fast_rewind, _audioHandler.rewind),
                  if (playing)
                    _button(Icons.pause, _audioHandler.pause)
                  else
                    _button(Icons.play_arrow, _audioHandler.play),
                  _button(Icons.stop, _audioHandler.stop),
                  _button(Icons.fast_forward, _audioHandler.fastForward),
                ],
              );
            },
          ),
          // A seek bar.
          StreamBuilder<MediaState>(
            stream: cubit.mediaStateStream,
            builder: (context, snapshot) {
              final mediaState = snapshot.data;
              return SeekBar(
                duration: mediaState?.mediaItem?.duration ?? Duration.zero,
                position: mediaState?.position ?? Duration.zero,
                onChangeEnd: (newPosition) {
                  _audioHandler.seek(newPosition);
                },
              );
            },
          ),
          // Display the processing state.
          StreamBuilder<AudioProcessingState>(
            stream: _audioHandler.playbackState
                .map((state) => state.processingState)
                .distinct(),
            builder: (context, snapshot) {
              final processingState =
                  snapshot.data ?? AudioProcessingState.idle;
              return Text(
                  // ignore: deprecated_member_use
                  'Processing state: ${describeEnum(processingState)}');
            },
          ),
        ],
      );
    });
  }

  IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
        icon: Icon(iconData),
        iconSize: 64.0,
        onPressed: onPressed,
      );
}
