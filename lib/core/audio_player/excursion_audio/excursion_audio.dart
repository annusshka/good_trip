import 'package:flutter/material.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/excursion_audio/excursion_audio_presenter.dart';
import 'package:good_trip/core/audio_player/excursion_audio/excursion_audio_view.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class ExcursionAudio extends StatelessWidget {
  const ExcursionAudio({
    super.key,
    required this.audioExcursion,
    this.tourName,
  });

  final AudioExcursion audioExcursion;
  final String? tourName;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => ExcursionAudioPresenter(
        audioPlayerHandler: getIt.get<AudioPlayerHandler>(),
        loadedAlbum: tourName ?? '${audioExcursion.id}_${audioExcursion.name}',
        excursionList: [audioExcursion],
      )..init(),
      child: const ExcursionAudioView(),
    );
  }
}
