import 'package:flutter/material.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler_impl.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler_impl2.dart';
import 'package:good_trip/core/audio_player/excursion_list/excursion_list_presenter.dart';
import 'package:good_trip/core/audio_player/excursion_list/excursion_list_presenter2.dart';
import 'package:good_trip/core/audio_player/excursion_list/excursion_list_view.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:provider/provider.dart';

class ExcursionList extends StatelessWidget {
  const ExcursionList({
    super.key,
    required this.excursionList,
    required this.tour,
    required this.viewedExcursionCount,
  });

  final List<IAudioExcursion> excursionList;
  final ITour tour;
  final int viewedExcursionCount;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => ExcursionListPresenter2(
        audioPlayerHandler: getIt.get<AudioPlayerHandlerImpl2>(),
        excursionList: excursionList,
        tourName: tour.name,
      )..init(),
      child: ExcursionListView(
        excursionList: excursionList,
        viewedExcursionCount: viewedExcursionCount,
        tourId: tour.id,
      ),
    );
  }
}
