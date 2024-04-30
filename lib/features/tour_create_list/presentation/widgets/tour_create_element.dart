import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/domain/models/models.dart';
import 'package:good_trip/core/presentation/widgets/tour_photo.dart';

import '../../../../core/theme/theme.dart';
import '../../../tour/presentation/widgets/widgets.dart';

class TourCreateElement extends StatelessWidget {
  const TourCreateElement(
      {super.key, required this.tour, required this.iconSize});

  final Tour tour;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Container(
      height: height * 0.5,
      decoration: BoxDecoration(
          //color: colors.lightGray,
          border: Border.all(color: colors.lightGray),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: InkWell(
        onTap: () {
          //context.pushRoute(PlantIdentRoute(plant: plant));
          AutoRouter.of(context).push(TourRoute(event: tour));
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TourPhoto(
                      photoUrl: tour.image,
                      icon: Icons.headphones_rounded,
                      size: height * 0.1),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  tour.name ?? '...',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  tour.kinds.join(', ') ?? '...',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const Flexible(
                flex: 2,
                child: TourTile(
                  titleText: 'Sun, Mar 22, 2020',
                  subtitleText: '8:30 PM - 10:00 PM',
                  icon: Icons.calendar_today_rounded,
                ),
              ),
              Flexible(
                flex: 2,
                child: TourTile(
                  titleText: '${tour.address[2] ?? ''},'
                      ' ${tour.address[3] ?? ''}',
                  subtitleText: '${tour.address[0] ?? ''}, '
                      '${tour.address[1] ?? ''}',
                  icon: Icons.location_on_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
