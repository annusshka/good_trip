import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/widgets/tour_photo.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/presentation/bloc/audio_tour/audio_tour.dart';
import '../../../core/presentation/bloc/tour/tour.dart';
import '../../../core/presentation/bloc/tour_list/tour_list.dart';
import '../../../core/presentation/widgets/widgets.dart';
import 'widgets/widgets.dart';

@RoutePage()
class TourScreen extends StatelessWidget {
  const TourScreen({super.key, required this.tour, this.audioFile});

  final BaseTour tour;
  final String? audioFile;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
        providers: [
          BlocProvider<TourBloc>(
            lazy: false,
            create: (_) => TourBloc(),
          ),
          BlocProvider<TourListBloc>(
            lazy: false,
            create: (_) => TourListBloc()
              ..add(const TourListRequested(lon: 38.364285, lat: 59.855685)),
          ),
          BlocProvider<AudioTourBloc>(
            lazy: false,
            create: (_) => AudioTourBloc(),
          ),
        ],
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: BackIconButton(color: Colors.white, iconSize: 24),
            ),
            actions: [
              BlocBuilder<TourBloc, TourState>(builder: (context, state) {
                return LikeButton(
                  iconSize: 24,
                  tour: tour,
                );
              }),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  bottom: 10,
                  left: 10,
                  right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.3,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: TourPhoto(
                        photoUrl: tour.image,
                        icon: audioFile == null
                            ? Icons.camera_alt
                            : Icons.headphones_rounded,
                        size: height * 0.1,
                      ),
                    ),
                  ),
                  Text(
                    tour.kinds.join(', '),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    tour.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TourTile(
                    titleText: tour.weekdays != null
                        ? tour.getWeekdays()
                        : 'Любой день',
                    subtitleText: '8:00 - 20:00',
                    icon: Icons.calendar_today_rounded,
                  ),
                  TourTile(
                    titleText: '${tour.address.street}'
                        ', ${tour.address.house}',
                    subtitleText: '${tour.address.country}, '
                        '${tour.address.city}',
                    icon: Icons.location_on_outlined,
                  ),
                  audioFile == null
                      ? const SizedBox.shrink()
                      : AudioContainer(
                          audioName: tour.name,
                          audioFilePath: audioFile!,
                        ),
                  const SizedBox(height: 15),
                  TourDescription(desc: tour.description ?? 'Неизвестно'),
                  BlocBuilder<TourListBloc, TourListState>(
                      builder: (context, state) {
                    if (state is TourListLoadSuccess &&
                        state.tourList.isNotEmpty) {
                      return SizedBox(
                        height: height * 0.35,
                        child: TourScrollList(
                            tourList: state.tourList, title: 'Вам понравилось'),
                      );
                    }
                    return const Center();
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}
