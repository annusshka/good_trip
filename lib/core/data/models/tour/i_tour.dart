import 'package:good_trip/core/data/models/address/i_address.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';

abstract class ITour {
  ITour({
    required this.id,
    required this.name,
    this.image,
    required this.address,
    this.weekdays,
    this.description,
    required this.kinds,
    this.isLiked = false,
    this.url,
  });

  final String id;
  final String name;
  final String? image;
  final IAddress address;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String> kinds;
  bool isLiked;
  final String? url;

  String getWeekdays() {
    return "${weekdays?.map((el) => el.displayTitle).join(', ')}";
  }
}
