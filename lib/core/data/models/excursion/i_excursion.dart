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
  final List<TourType> kinds;
  bool isLiked;
  final String? deeplinkUrl;

  String getWeekdays() {
    return weekdays != null ? "${weekdays?.map((el) => el.displayTitle).join(', ')}" : 'Любой день';
  }

  String getKinds() {
    List<String> tourTypes = [];
    for (final TourType type in kinds) {
      tourTypes.add(type.displayText);
    }
    return tourTypes.join(', ');
  }

  String getAddressDetails() {
    final street = address.street ?? '';
    final house = address.house ?? '';
    if (street.isEmpty && house.isEmpty) return '${address.country}, ${address.city}';
    if (street.isEmpty && house.isNotEmpty) return house;
    if (street.isNotEmpty && house.isEmpty) return street;
    return '$street, $house';
  }

  String getAddressRegion() {
    if ((address.street ?? '').isEmpty && (address.house ?? '').isEmpty) return '';
    return '${address.country}, ${address.city}';
  }
}
