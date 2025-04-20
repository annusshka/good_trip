import 'package:flutter/material.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/excursion_list/excursion_list_presenter.dart';
import 'package:good_trip/core/audio_player/excursion_list/excursion_list_view.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:good_trip/features/tour_create/presentation/widgets/excursion_card_list_view.dart';
import 'package:provider/provider.dart';

class ExcursionCardList extends StatelessWidget {
  const ExcursionCardList({
    super.key,
    required this.tourName,
    required this.excursionList, this.onTapAction,
  });

  final String tourName;
  final List<AudioExcursion> excursionList;
  final Function(IExcursion)? onTapAction;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) =>
      ExcursionListPresenter(
        audioPlayerHandler: getIt.get<AudioPlayerHandler>(),
        loadedAlbum: tourName,
        excursionList: excursionList,
      )
        ..init(),
      child: ExcursionCardListView(
        excursionList: excursionList,
        tourName: tourName,
        onTapAction: onTapAction,
      ),
    );
  }
}
