import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/audio_player/data/position_data.dart';
import 'package:good_trip/core/audio_player/excursion_audio/excursion_audio_presenter.dart';
import 'package:good_trip/core/audio_player/excursion_card/widgets/seek_bar.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ExcursionAudioPresenter>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<bool>(
          stream: presenter.isActualAudio,
          builder: (context, snapshot1) {
            final isActualAudio = snapshot1.data ?? false;

            if (!isActualAudio) {
              return InkWell(
                onTap: presenter.playNewAudio,
                child: const Icon(
                  Icons.play_arrow,
                  size: 24.0,
                  color: AppColors.pink,
                ),
              );
            } else {
              return StreamBuilder<PlaybackState>(
                stream: presenter.audioPlayerHandler.playbackState,
                builder: (context, snapshot) {
                  final playbackState = snapshot.data;
                  final processingState = playbackState?.processingState;
                  final playing = playbackState?.playing;
                  if (processingState == AudioProcessingState.loading ||
                      processingState == AudioProcessingState.buffering) {
                    return const SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(
                        color: AppColors.pink,
                      ),
                    );
                  } else if (playing != true) {
                    return InkWell(
                      onTap: presenter.playNewAudio,
                      child: const Icon(
                        Icons.play_arrow,
                        size: 24.0,
                        color: AppColors.pink,
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: presenter.pause,
                      child: const Icon(
                        Icons.pause,
                        size: 24.0,
                        color: AppColors.pink,
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }
}

class ExcursionAudioView extends StatelessWidget {
  const ExcursionAudioView({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ExcursionAudioPresenter>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ControlButtons(),
        StreamBuilder<PositionData>(
          stream: presenter.positionDataStream,
          builder: (context, snapshot) {
            return StreamBuilder<bool>(
              stream: presenter.isActualAudio,
              builder: (context, snp) {
                final isActualAudio = snp.data ?? false;
                late final PositionData positionData;
                final data = snapshot.data;
                if (snapshot.hasData && data != null) {
                  positionData = isActualAudio
                      ? data
                      : PositionData(
                          Duration.zero,
                          Duration.zero,
                          data.duration,
                        );
                } else {
                  positionData = PositionData(
                    Duration.zero,
                    Duration.zero,
                    Duration.zero,
                  );
                }
                return Expanded(
                  child: SeekBar(
                    duration: positionData.duration,
                    position: positionData.position,
                    bufferedPosition: positionData.bufferedPosition,
                    onChangeEnd: presenter.audioPlayerHandler.seek,
                    isActualAudio: isActualAudio,
                    playFunc: () async {
                      await presenter.playNewAudio();
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
