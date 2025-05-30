import 'package:good_trip/core/data/models/models.dart';

abstract class ITour {
  ITour({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.address,
    this.weekdays,
    this.description,
    required this.kinds,
    this.isLiked = false,
    this.deeplinkUrl,
    required this.excursionList,
  });

  final String id;
  final String name;
  final String? imageUrl;
  final IAddress address;
  final List<Weekday>? weekdays;
  final String? description;
  final List<TourType> kinds;
  bool isLiked;
  final String? deeplinkUrl;
  final List<IAudioExcursion> excursionList;

  String getWeekdays();

  String getKinds();

  String getAddressDetails();

  String getAddressRegion();
}