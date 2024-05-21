import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'seekbar.dart';
import 'widgets.dart';

class AudioContainer extends StatefulWidget {
  const AudioContainer({super.key, required this.audioFile});

  final String audioFile;

  @override
  _AudioContainerState createState() => _AudioContainerState();
}

class _AudioContainerState extends State<AudioContainer> {
  File get _audioFile => File(widget.audioFile);
  final AudioPlayer _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    _player.setFilePath(_audioFile.path);
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(right: 40),
          leading: const Icon(
            Icons.headphones_rounded,
            color: Colors.black,
            size: 24,
          ),
          title: Text(
            _audioFile.path.split('/').last,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 10),
        Row(
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
                  // Loading
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 30,
                    height: 30,
                    child: const CircularProgressIndicator(),
                  );
                } else if (playing != true) {
                  return GestureDetector(
                    onTap: () {
                      _player.play();
                    },
                    child: const Icon(
                      Icons.play_arrow,
                      size: 30,
                    ),
                  );
                } else if (processingState != ProcessingState.completed) {
                  return GestureDetector(
                    onTap: () {
                      _player.pause();
                    },
                    child: const Icon(
                      Icons.pause,
                      size: 30,
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
                      size: 30,
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
                    (position, bufferedPosition) =>
                        PositionData(position, bufferedPosition),
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
        ),
      ],
    );
  }
}
