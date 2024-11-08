import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/excursion/excursion.dart';
import 'package:good_trip/core/presentation/bloc/excursion_list/excursion_list.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

import 'widgets/widgets.dart';

@RoutePage()
class ExcursionScreen extends StatelessWidget {
  const ExcursionScreen({super.key, required this.tour});

  final IExcursion tour;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final audioTour = tour is AudioExcursion ? (tour as AudioExcursion).audioUrl : null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: BackIconButton(color: Colors.white, iconSize: 24),
        ),
        actions: [
          BlocBuilder<ExcursionBloc, ExcursionState>(builder: (context, state) {
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
                  child: ExcursionPhoto(
                    photoUrl: tour.imageUrl,
                    icon: audioTour == null
                        ? Icons.camera_alt
                        : Icons.headphones_rounded,
                    size: height * 0.1,
                  ),
                ),
              ),
              Text(
                tour.kinds.join(', '),
                textAlign: TextAlign.left,
                style: AppTextTheme.medium14.copyWith(
                  color: AppColors.lightGray,
                ),
              ),
              Text(
                tour.name,
                textAlign: TextAlign.left,
                style: AppTextTheme.semiBold26,
              ),
              TourTile(
                titleText:
                    tour.weekdays != null ? tour.getWeekdays() : 'Любой день',
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
              if (audioTour == null)
                const SizedBox.shrink()
              else
                AudioContainer(
                  audioName: tour.name,
                  audioFilePath: audioTour,
                ),
              const SizedBox(height: 15),
              TourDescription(desc: tour.description ?? 'Неизвестно'),
              BlocBuilder<ExcursionListBloc, ExcursionListState>(
                  builder: (context, state) {
                if (state is ExcursionListLoadSuccess && state.excursionList.isNotEmpty) {
                  return SizedBox(
                    height: height * 0.35,
                    child: ExcursionScrollList(
                        tourList: state.excursionList, title: 'Вам понравилось'),
                  );
                }
                return const Center();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
