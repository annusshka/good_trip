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
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          TourPhoto(
                            photoUrl: tour.image,
                            icon: audioFile == null
                                ? Icons.camera_alt
                                : Icons.headphones_rounded,
                            size: height * 0.1,
                          ),
                          OverflowBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BackIconButton(
                                  color: Colors.white, iconSize: 24),
                              BlocBuilder<TourBloc, TourState>(
                                  builder: (context, state) {
                                return LikeButton(
                                  iconSize: 24,
                                  tour: tour,
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          titleText: '${tour.address.street}, '
                              '${tour.address.house}',
                          subtitleText: '${tour.address.country}, '
                              '${tour.address.city}',
                          icon: Icons.location_on_outlined,
                        ),
                        audioFile == null
                            ? const SizedBox.shrink()
                            : AudioContainer(
                                audioFile: audioFile!,
                              ),
                        const SizedBox(height: 15),
                        TourDescription(desc: tour.description ?? 'Неизвестно'),
                        BlocBuilder<TourListBloc, TourListState>(
                            builder: (context, state) {
                          if (state is TourListLoadSuccess &&
                              state.tourList.isNotEmpty) {
                            return TourScrollList(
                                tourList: state.tourList,
                                title: 'Вам понравилось');
                          }
                          return const Center();
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
