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
  const ExcursionScreen({super.key, required this.excursion});

  final IExcursion excursion;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final audioTour = excursion is AudioExcursion
        ? (excursion as AudioExcursion).audioUrl
        : null;

    return Scaffold(
      //extendBodyBehindAppBar: true,
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: const Padding(
      //     padding: EdgeInsets.only(left: 10),
      //     child: BackIconButton(color: Colors.white, iconSize: 24),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 10),
      //       child: BlocBuilder<ExcursionBloc, ExcursionState>(
      //           builder: (context, state) {
      //         return LikeButton(
      //           iconSize: 24,
      //           excursion: excursion,
      //         );
      //       }),
      //     ),
      //   ],
      // ),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: ExcursionPhoto(
                        photoUrl: excursion.imageUrl,
                        icon: Icons.camera_alt,
                        size: height * 0.1,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const BackIconButton(
                        color: Colors.white,
                        iconSize: 24,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<ExcursionBloc, ExcursionState>(
                          builder: (context, state) {
                        return LikeButton(
                          iconSize: 24,
                          excursion: excursion,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  excursion.getKinds(),
                  textAlign: TextAlign.left,
                  style: AppTextTheme.medium14.copyWith(
                    color: AppColors.lightGray,
                  ),
                ),
              ),
              Text(
                excursion.name,
                textAlign: TextAlign.left,
                style: AppTextTheme.semiBold26,
              ),
              TourTile(
                titleText: excursion.getWeekdays(),
                subtitleText: '8:00 - 20:00',
                icon: Icons.calendar_today_rounded,
              ),
              TourTile(
                titleText: excursion.getAddressDetails(),
                subtitleText: excursion.getAddressRegion(),
                icon: Icons.location_on_outlined,
              ),
              if (audioTour != null) ...[
                ListTile(
                  contentPadding: const EdgeInsets.only(right: 40),
                  leading: const Icon(
                    Icons.headphones_rounded,
                    color: Colors.black,
                    size: 24,
                  ),
                  title: Text(
                    excursion.name,
                    textAlign: TextAlign.left,
                    style: AppTextTheme.medium14.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                AudioContainer(
                  audioFilePath: audioTour,
                ),
              ],
              const SizedBox(height: 15),
              TourDescription(desc: excursion.description ?? 'Неизвестно'),
              BlocBuilder<ExcursionListBloc, ExcursionListState>(
                  builder: (context, state) {
                if (state is ExcursionListLoadSuccess &&
                    state.excursionList.isNotEmpty) {
                  return SizedBox(
                    height: height * 0.35,
                    child: ExcursionScrollList(
                        tourList: state.excursionList,
                        title: 'Вам понравилось'),
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
