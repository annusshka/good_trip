import 'package:flutter/material.dart';
import 'package:good_trip/repositories/models/event.dart';

class EventListTile extends StatelessWidget {
  const EventListTile({
    super.key,
    required this.event
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          event.name
        //style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        /* способ 1
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TripScreen(),
                ),
              );*/
        // способ 2
        Navigator.of(context).pushNamed(
          '/event',
          arguments: event,
        );
      },
    );
  }
}