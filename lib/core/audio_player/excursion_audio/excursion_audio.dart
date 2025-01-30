import 'package:flutter/material.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler_impl.dart';
import 'package:good_trip/core/audio_player/excursion_audio/excursion_audio_presenter.dart';
import 'package:good_trip/core/audio_player/excursion_audio/excursion_audio_view.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/di/set_up_locator.dart';
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
      create: (BuildContext context) => ExcursionAudioPresenter(
        index: index,
        audioPlayerHandler: getIt.get<AudioPlayerHandlerImpl>(),
        excursion: audioExcursion,
        tourName: tourName,
      )..init(),
      child: const ExcursionAudioView(),
    );
  }
}
