import 'package:flutter/material.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/excursion_audio/excursion_audio_presenter2.dart';
import 'package:good_trip/core/audio_player/excursion_audio/excursion_audio_view.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class ExcursionAudio extends StatelessWidget {
  const ExcursionAudio({
    super.key,
    required this.audioExcursion,
    this.index,
    this.tourName,
  });

  final AudioExcursion audioExcursion;
  final int? index;
  final String? tourName;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => ExcursionAudioPresenter2(
        index: index,
        audioPlayerHandler: getIt.get<AudioPlayerHandler>(),
        excursion: audioExcursion,
        tourName: tourName,
        audioPlayer: getIt.get<AudioPlayer>(),
      )..init(),
      child: const ExcursionAudioView(),
    );
  }
}
