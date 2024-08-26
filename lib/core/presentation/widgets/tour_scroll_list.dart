import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';

class TourScrollList extends StatefulWidget {
  const TourScrollList({super.key,
    required this.tourList, required this.title});

  final List<ITour> tourList;
  final String title;

  @override
  State<TourScrollList> createState() => _TourScrollListState();
}

class _TourScrollListState extends State<TourScrollList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*
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
        ),*/
        Expanded(
          flex: 2,
          child: Text(widget.title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const Spacer(flex: 1,),
        Expanded(
          flex: 15,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.tourList.length,
            separatorBuilder: (BuildContext context, _) => const SizedBox(width: 10,),
            itemBuilder: (context, i) {
              final tour = widget.tourList[i];
              return TourScrollElement(tour: tour);
            },
          ),
        ),
      ],
    );
  }
}
