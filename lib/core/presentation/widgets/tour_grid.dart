import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';

class TourGrid extends StatelessWidget {
  final List<ITour> tourList;
  const TourGrid({super.key, required this.tourList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: tourList.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 7,
        ),
        itemBuilder: (context, index) {
          return TourScrollElement(tour: tourList[index]);
        },
      ),
    );
  }
}
