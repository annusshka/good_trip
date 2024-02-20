import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repositories/service/service.dart';
import 'package:good_trip/core/presentation/widgets/tour_scroll_list.dart';

import 'widgets/widgets.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  Tour? event;
  List<Tour>? eventLikedList = [];

  Future<void> _loadEventList() async{
    // Если метод не static, то вызывается через TourService()
    eventLikedList = await TourService.getTourList(lon: '38.364285', lat: '59.855685', limit: 10);
    setState(() {});
  }

  @override
  void initState() {
    _loadEventList();
    super.initState();
  }

  void _tapLike() {
    event!.isLiked = !event!.isLiked;
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null) {
      log('You must provide args');
      return;
    }
    if (args is! Tour) {
      log("Args must be Event");
      return;
    }
    event = args;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
              top: 40, bottom:10,
              left:10, right:10),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.25,
                //width: width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(event?.image ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            alignment: Alignment.center,
                            child: Icon(Icons.camera_alt, size: height * 0.1,),
                          );
                        },
                      ),
                      OverflowBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.arrow_back_ios),
                            iconSize: 24,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              event!.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 24,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _tapLike();
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event?.kinds.join(', ') ?? '...',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(event?.name ?? '...',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const TourTile(
                      titleText: 'Sun, Mar 22, 2020',
                      subtitleText: '8:30 PM - 10:00 PM',
                      icon: Icons.calendar_today_rounded,
                    ),
                    TourTile(
                      titleText: '${event?.address[2] ?? ''}, ${event?.address[3] ?? ''}',
                      subtitleText: '${event?.address[0] ?? ''}, ${event?.address[1] ?? ''}',
                      icon: Icons.location_on_outlined,
                    ),
                    TourDescription(desc: event?.description ?? 'Неизвестно'),
                    Visibility(
                      visible: eventLikedList!.isNotEmpty,
                      child: TourScrollList(
                          tourList: eventLikedList!,
                          title: 'Вам понравилось'
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
