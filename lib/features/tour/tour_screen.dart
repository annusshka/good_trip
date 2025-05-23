import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/excursion_list/excursion_list.dart';
import 'package:good_trip/core/audio_player/excursion_list/excursion_list_view.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/bloc.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:good_trip/features/excursion/presentation/widgets/widgets.dart';
import 'package:good_trip/features/map/map_screen.dart';
import 'package:good_trip/features/tour/presentation/bloc/viewed_excursions/viewed_excursions.dart';
import 'package:just_audio/just_audio.dart';

@RoutePage()
class TourScreen extends StatelessWidget {
  const TourScreen({super.key, required this.tour});

  final ITour tour;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final coordList = tour.excursionList.map((excursion) => excursion.address.coordinates).toList();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ViewedExcursionsCubit>(
          lazy: false,
          create: (_) => ViewedExcursionsCubit(
            tourRepository: getIt.get<ITourRepository>(),
          )..requestViewedExcursion(tourId: tour.id),
        ),
      ],
      child: Scaffold(
        //extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: 10,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.3,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ExcursionPhoto(
                            photoUrl: tour.imageUrl,
                            icon: Icons.camera_alt,
                            size: height * 0.1,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const BackIconButton(color: AppColors.pink, iconSize: 24),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.all(8.0),
                        child: TourLikeButton(
                          iconSize: 24.0,
                          tour: tour,
                          iconColor: AppColors.pink,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    tour.getKinds(),
                    textAlign: TextAlign.left,
                    style: AppTextTheme.medium14.copyWith(
                      color: AppColors.lightGray,
                    ),
                  ),
                ),
                Text(
                  tour.name,
                  textAlign: TextAlign.left,
                  style: AppTextTheme.semiBold26,
                ),
                TourTile(
                  titleText: tour.getWeekdays(),
                  subtitleText: '8:00 - 20:00',
                  icon: Icons.calendar_today_rounded,
                ),
                TourTile(
                  titleText: tour.getAddressDetails(),
                  subtitleText: tour.getAddressRegion(),
                  icon: Icons.location_on_outlined,
                ),
                const SizedBox(height: 8.0),
                if (coordList.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    height: 150.0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                      child: MapScreen(
                        mapPoints: coordList,
                        showAppBar: false,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          AutoRouter.of(context).push(
                            MapRoute(
                              mapPoints: coordList,
                              initialZoom: 5.0,
                            ),
                          );
                        },
                        child: Text(
                          'Смотреть на карте',
                          textAlign: TextAlign.right,
                          style: AppTextTheme.medium14.copyWith(
                            color: AppColors.lightGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                ],
                TourDescription(desc: tour.description ?? 'Неизвестно'),
                if (tour.excursionList.isNotEmpty) ...[
                  const Text(
                    'Детали тура',
                    textAlign: TextAlign.left,
                    style: AppTextTheme.semiBold18,
                  ),
                  BlocBuilder<ViewedExcursionsCubit, ViewedExcursionsState>(
                    builder: (context, state) {
                      return ExcursionList(
                        viewedExcursionCount: state.excursionCount,
                        tour: tour as Tour,
                      );
                    },
                  ),
                ],
                const SizedBox(height: 16.0),
                BlocBuilder<ExcursionListBloc, ExcursionListState>(
                  builder: (context, state) {
                    if (state is ExcursionListLoadSuccess && state.excursionList.isNotEmpty) {
                      return SizedBox(
                        height: height * 0.35,
                        child: ExcursionScrollList(tourList: state.excursionList, title: 'Смотрите также'),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
