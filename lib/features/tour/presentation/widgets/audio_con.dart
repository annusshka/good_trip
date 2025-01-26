import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/audio_player/data/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/data/position_data.dart';
import 'package:good_trip/core/audio_player/data/queue_state.dart';
import 'package:good_trip/core/audio_player/presentation/bloc/audio_player_cubit.dart';
import 'package:good_trip/core/audio_player/presentation/widgets/seek_bar.dart';

class ControlButtons extends StatelessWidget {
  final AudioPlayerHandler audioHandler;

  const ControlButtons({
    required this.audioHandler,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<QueueState>(
          stream: audioHandler.queueState,
          builder: (context, snapshot) {
            final queueState = snapshot.data ?? QueueState.empty;
            return InkWell(
              child: const Icon(Icons.skip_previous),
              onTap:
                  queueState.hasPrevious ? audioHandler.skipToPrevious : null,
            );
          },
        ),
        StreamBuilder<PlaybackState>(
          stream: audioHandler.playbackState,
          builder: (context, snapshot) {
            final playbackState = snapshot.data;
            final processingState = playbackState?.processingState;
            final playing = playbackState?.playing;
            if (processingState == AudioProcessingState.loading ||
                processingState == AudioProcessingState.buffering) {
              return Container(
                width: 24.0,
                height: 24.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return InkWell(
                child: const Icon(Icons.play_arrow, size: 24.0,),
                onTap: audioHandler.play,
              );
            } else {
              return InkWell(
                child: const Icon(Icons.pause, size: 24.0,),
                onTap: audioHandler.pause,
              );
            }
          },
        ),
        StreamBuilder<QueueState>(
          stream: audioHandler.queueState,
          builder: (context, snapshot) {
            final queueState = snapshot.data ?? QueueState.empty;
            return InkWell(
              child: const Icon(Icons.skip_next),
              onTap: queueState.hasNext ? audioHandler.skipToNext : null,
            );
          },
        ),
      ],
    );
  }
}

class AudioCon extends StatelessWidget {
  const AudioCon({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AudioPlayerCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ControlButtons(
          audioHandler: cubit.audioPlayerHandler,
        ),
        StreamBuilder<PositionData>(
          stream: cubit.positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data ??
                PositionData(Duration.zero, Duration.zero, Duration.zero);
            return SeekBar(
              duration: positionData.duration,
              position: positionData.position,
              onChangeEnd: (newPosition) {
                cubit.audioPlayerHandler.seek(newPosition);
              },
            );
          },
        ),
      ],
    );
  }
}
