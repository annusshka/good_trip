import 'package:good_trip/core/data/models/address/i_address.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';

abstract class IExcursion {
  IExcursion({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.address,
    this.weekdays,
    this.description,
    required this.kinds,
    this.isLiked = false,
    this.deeplinkUrl,
  });

  final String id;
  final String name;
  final String? imageUrl;
  final IAddress address;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String> kinds;
  bool isLiked;
  final String? deeplinkUrl;

  String getWeekdays() {
    return "${weekdays?.map((el) => el.displayTitle).join(', ')}";
  }
}
