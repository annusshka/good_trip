import 'package:flutter/material.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';

import '../../domain/models/models.dart';

class TourScrollList extends StatefulWidget {
  const TourScrollList({super.key,
    required this.tourList, required this.title, this.icon = Icons.camera_alt});

  final List<Tour> tourList;
  final String title;
  final IconData icon;

  @override
  State<TourScrollList> createState() => _TourScrollListState();
}

class _TourScrollListState extends State<TourScrollList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              children: [
                Text('Show all',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromARGB(255, 255, 158, 162),
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 248,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.tourList.length,
            separatorBuilder: (BuildContext context, _) => const SizedBox(width: 10,),
            itemBuilder: (context, i) {
              final tour = widget.tourList[i];
              return TourScrollElement(tour: tour, imageIcon: widget.icon,);
            },
          ),
        ),
      ],
    );
  }
}
