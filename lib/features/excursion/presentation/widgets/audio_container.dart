import 'package:flutter/material.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'seekbar.dart';
import 'widgets.dart';

class AudioContainer extends StatefulWidget {
  const AudioContainer({super.key, required this.audioFilePath});

  final String audioFilePath;

  @override
  _AudioContainerState createState() => _AudioContainerState();
}

class _AudioContainerState extends State<AudioContainer> {
  final AudioPlayer _player = AudioPlayer();

  void initAudio() {
    _player.setLoopMode(LoopMode.one);
  }

  @override
  void initState() {
    initAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_player.setFilePath(_audioFile.path);
    final url = '$baseBDUrl/${widget.audioFilePath}';
    _player.setUrl(url);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StreamBuilder<PlayerState>(
          stream: _player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;

            if (playerState == null) {
              return const SizedBox.shrink();
            }

            final processingState = playerState.processingState;

            final playing = playerState.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 24,
                height: 24,
                child: const CircularProgressIndicator(color: AppColors.pink,),
              );
            } else if (playing != true) {
              return GestureDetector(
                onTap: _player.play,
                child: const Icon(
                  Icons.play_arrow,
                  color: AppColors.pink,
                  size: 24,
                ),
              );
            } else if (processingState != ProcessingState.completed) {
              return GestureDetector(
                onTap: _player.pause,
                child: const Icon(
                  Icons.pause,
                  color: AppColors.pink,
                  size: 24,
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  _player.seek(
                    Duration.zero,
                    index: _player.effectiveIndices!.first,
                  );
                },
                child: const Icon(
                  Icons.replay,
                  color: AppColors.pink,
                  size: 24,
                ),
              );
            }
          },
        ),
        StreamBuilder<Duration?>(
          stream: _player.durationStream,
          builder: (context, snapshot) {
            final duration = snapshot.data ?? Duration.zero;

            return StreamBuilder<PositionData>(
              stream:
                  Rx.combineLatest2<Duration, Duration, PositionData>(
                _player.positionStream,
                _player.bufferedPositionStream,
                PositionData.new,
              ),
              builder: (context, snapshot) {
                final positionData = snapshot.data ??
                    PositionData(Duration.zero, Duration.zero);
                var position = positionData.position;
                if (position > duration) {
                  position = duration;
                }
                var bufferedPosition = positionData.bufferedPosition;
                if (bufferedPosition > duration) {
                  bufferedPosition = duration;
                }

                return Expanded(
                  child: SeekBar(
                    duration: duration,
                    position: position,
                    bufferedPosition: bufferedPosition,
                    onChangeEnd: (newPosition) {
                      _player.seek(newPosition ?? const Duration());
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
