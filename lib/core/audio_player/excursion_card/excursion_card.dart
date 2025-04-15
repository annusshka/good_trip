import 'package:flutter/material.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler_impl2.dart';
import 'package:good_trip/core/audio_player/excursion_card/excursion_card_presenter.dart';
import 'package:good_trip/core/audio_player/excursion_card/excursion_card_presenter2.dart';
import 'package:good_trip/core/audio_player/excursion_card/excursion_card_view.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:provider/provider.dart';

class ExcursionCard extends StatelessWidget {
  const ExcursionCard({
    super.key,
    required this.audioExcursion,
    required this.index,
  });

  final AudioExcursion audioExcursion;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => ExcursionCardPresenter2(
        index: index,
        audioPlayerHandler: getIt.get<AudioPlayerHandler>(),
      )..init(),
      child: ExcursionCardView(
        excursion: audioExcursion,
      ),
    );
  }
}
