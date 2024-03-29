import 'package:flutter/material.dart';
import 'package:good_trip/core/presentation/widgets/tour_scroll_element.dart';

import '../../domain/models/models.dart';

class TourGrid extends StatelessWidget {
  final List<Tour> tourList;
  const TourGrid({super.key, required this.tourList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: tourList.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return TourScrollElement(tour: tourList[index]);
        },
      ),
    );
  }
}
