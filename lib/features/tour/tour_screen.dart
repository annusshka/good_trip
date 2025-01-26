import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/excursion/excursion.dart';
import 'package:good_trip/core/presentation/bloc/excursion_list/excursion_list.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion/presentation/widgets/widgets.dart';

import 'presentation/widgets/excursion_list.dart';

@RoutePage()
class TourScreen extends StatelessWidget {
  const TourScreen({super.key, required this.tour});

  final ITour tour;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: ExcursionPhoto(
                        photoUrl: tour.imageUrl,
                        icon: Icons.camera_alt,
                        size: height * 0.1,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: const BackIconButton(
                          color: Colors.white, iconSize: 24),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<ExcursionBloc, ExcursionState>(
                        builder: (context, state) {
                          return InkWell(
                            child: Icon(
                              tour.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 24,
                              color: AppColors.white,
                            ),
                            onTap: () {
                              tour.isLiked = !tour.isLiked;
                              BlocProvider.of<ExcursionBloc>(context)
                                  .add(ExcursionLikeRequested(id: tour.id));
                            },
                          );
                        },
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
              const SizedBox(height: 16.0),
              TourDescription(desc: tour.description ?? 'Неизвестно'),
              if (tour.excursionList.isNotEmpty) ...[
                const Text(
                  'Детали тура',
                  textAlign: TextAlign.left,
                  style: AppTextTheme.semiBold18,
                ),
                ExcursionList(
                  excursionList: tour.excursionList,
                  tour: tour,
                ),
              ],
              const SizedBox(height: 16.0),
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
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
