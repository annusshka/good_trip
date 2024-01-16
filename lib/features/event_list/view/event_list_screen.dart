import 'package:flutter/material.dart';
import 'package:good_trip/repositories/event/event.dart';

import '../widgets/widgets.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {

  List<Event>? _eventList;

  @override
  void initState() {
    _loadEventList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Good Trip'),
      ),
      body: (_eventList == null)
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _eventList!.length,
        itemBuilder: (context, i) {
          final event = _eventList![i];
          return EventListTile(event: event);
        },
      ),
    );
  }

  Future<void> _loadEventList() async{
    _eventList = await EventRepository().getTripEventList();
    setState(() {});
  }
}
