import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';

class ExcursionGrid extends StatelessWidget {
  final List<IExcursion> excursionList;
  const ExcursionGrid({super.key, required this.excursionList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: excursionList.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 7,
        ),
        itemBuilder: (context, index) {
          return ExcursionScrollElement(excursion: excursionList[index]);
        },
      ),
    );
  }
}
