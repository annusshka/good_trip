import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:good_trip/repositories/event/event.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Event? event;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null) {
      log('You must provide args');
      return;
    }
    if (args is! Event) {
      log("Args must be Event");
      return;
    }
    event = args;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(event?.name ?? '...'),),
      body: ListView(
        padding: const EdgeInsets.only(top: 40, bottom:10, left:10, right:10),
        //alignment: Alignment.topCenter,
          children: [
            Stack(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                event?.image != null ?
                ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: SizedBox.fromSize(
                    //size: const Size.fromRadius(70), // Image radius
                    child: Image.network(event!.image as String, fit: BoxFit.cover),
                  ),
                )
                    : const Icon(Icons.error, size: 24,),
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 24,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Text(event?.kinds.join(', ') ?? '...',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Gilroy-Medium',
                  color: Color.fromARGB(100, 181, 181, 190)),
            ),
            Text(event?.name ?? '...',
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 26, fontFamily: 'Alatsy'),
              ),
            const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.location_on_outlined, color: Colors.black,),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('13.01.2024',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Gilroy-Medium',
                              color: Color.fromARGB(100, 23, 23, 37)),
                        ),
                      ]
                  )
                ]
            ),
            const Text('About',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Gilroy-SemiBold',
                  color: Colors.black),
            ),
            ClipRRect(
              //borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                size: const Size.fromRadius(70),
                child: Text(event?.description ?? '...',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Gilroy-Regular',
                      color: Color.fromARGB(100, 105, 105, 116)),
                  softWrap: true,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
            ),
            ),
          ]
      ),
    );
  }
}
