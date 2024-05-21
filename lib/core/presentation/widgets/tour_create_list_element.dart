import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/domain/models/models.dart';
import 'package:good_trip/core/presentation/widgets/tour_photo.dart';

import '../../../features/tour_create/presentation/bloc/tour_create.dart';
import '../../theme/theme.dart';
import '../../../features/tour/presentation/widgets/widgets.dart';

class TourCreateListElement extends StatelessWidget {
  const TourCreateListElement(
      {super.key, required this.tour, required this.iconSize});

  final AudioTour tour;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Container(
      height: height * 0.5,
      decoration: BoxDecoration(
          border: Border.all(color: colors.lightGray),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: InkWell(
        onTap: () {
          context.pushRoute(TourRoute(tour: tour, audioFile: tour.audioFile));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: TourPhoto(
                        photoUrl: tour.image,
                        icon: Icons.headphones_rounded,
                        size: height * 0.1),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  tour.name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Flexible(
                child: Text(
                  tour.kinds.join(', '),
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Flexible(
                flex: 2,
                child: TourTile(
                  titleText:
                      tour.weekdays != null ? tour.getWeekdays() : 'Любой день',
                  subtitleText: '8:00 - 20:00',
                  icon: Icons.calendar_today_rounded,
                ),
              ),
              Flexible(
                flex: 2,
                child: TourTile(
                  titleText: '${tour.address.street},'
                      ' ${tour.address.house}',
                  subtitleText: '${tour.address.country}, '
                      '${tour.address.city}',
                  icon: Icons.location_on_outlined,
                ),
              ),
              Flexible(
                flex: 3,
                child: BlocBuilder<TourCreateBloc, TourCreateState>(
                    builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        color: colors.pink_,
                        child: TextButton(
                          onPressed: () {
                            BlocProvider.of<TourCreateBloc>(context).add(
                                CreatedTourRemoveRequested(tourId: tour.id));
                          },
                          child: Text(
                            'Удалить',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.merge(TextStyle(color: colors.white)),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
