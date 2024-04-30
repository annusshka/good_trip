import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/presentation/widgets/tour_photo.dart';

import '../../../core/domain/models/models.dart';
import '../../../core/domain/service/service.dart';
import '../../../core/presentation/widgets/widgets.dart';
import 'widgets/widgets.dart';

@RoutePage()
class TourScreen extends StatefulWidget {
  const TourScreen({super.key, required this.event});

  final Tour event;

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  List<Tour>? eventLikedList = [];

  Future<void> _loadEventList() async {
    eventLikedList = await TourService.getTourList(
        lon: '38.364285', lat: '59.855685', limit: 10);
    setState(() {});
  }

  @override
  void initState() {
    _loadEventList();
    super.initState();
  }

  void _tapLike() {
    widget.event.isLiked = !widget.event.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(top: 40, bottom: 10, left: 10, right: 10),
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
                      TourPhoto(
                        photoUrl: widget.event.image,
                        icon: Icons.camera_alt,
                        size: height * 0.1,
                      ),
                      OverflowBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BackIconButton(color: Colors.white, iconSize: 24),
                          IconButton(
                            icon: Icon(
                              widget.event.isLiked
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.kinds.join(', ') ?? '...',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      widget.event.name ?? '...',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const TourTile(
                      titleText: 'Sun, Mar 22, 2020',
                      subtitleText: '8:30 PM - 10:00 PM',
                      icon: Icons.calendar_today_rounded,
                    ),
                    TourTile(
                      titleText: '${widget.event.address[2] ?? ''},'
                          ' ${widget.event.address[3] ?? ''}',
                      subtitleText: '${widget.event.address[0] ?? ''}, '
                          '${widget.event.address[1] ?? ''}',
                      icon: Icons.location_on_outlined,
                    ),
                    TourDescription(
                        desc: widget.event.description ?? 'Неизвестно'),
                    Visibility(
                      visible: eventLikedList!.isNotEmpty,
                      child: TourScrollList(
                          tourList: eventLikedList!, title: 'Вам понравилось'),
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
