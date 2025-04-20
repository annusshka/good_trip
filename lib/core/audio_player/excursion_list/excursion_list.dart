import 'package:flutter/material.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/excursion_list/excursion_list_presenter.dart';
import 'package:good_trip/core/audio_player/excursion_list/excursion_list_view.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:provider/provider.dart';

class ExcursionList extends StatelessWidget {
  const ExcursionList({
    super.key,
    required this.viewedExcursionCount,
    required this.tour,
  });

  final int viewedExcursionCount;
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => ExcursionListPresenter(
        audioPlayerHandler: getIt.get<AudioPlayerHandler>(),
        loadedAlbum: '${tour.id}_${tour.name}',
        excursionList: tour.excursionList,
      )..init(),
      child: ExcursionListView(
        viewedExcursionCount: viewedExcursionCount,
        tour: tour,
      ),
    );
  }
}
