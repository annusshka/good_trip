import 'package:good_trip/core/data/models/address/address.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';

import '../tour/i_tour.dart';

abstract class IAudioTour extends ITour {

  IAudioTour({
    required String id,
    required String name,
    String? image,
    required Address address,
    List<Weekday>? weekdays,
    String? description,
    required List<String> kinds,
    bool isLiked = false,
    String? url,
    required this.audio,
  }) : super(
    id: id,
    name: name,
    image: image,
    address: address,
    weekdays: weekdays,
    description: description,
    kinds: kinds,
    isLiked: isLiked,
    url: url,
  );
  //
  // IAudioTour({
  //   required super.id,
  //   required super.name,
  //   this.image,
  //   required super.address,
  //   this.weekdays,
  //   this.description,
  //   required super.kinds,
  //   this.isLiked = false,
  //   this.url,
  //   required this.audio,
  // });
  // @override
  // final String? image;
  // @override
  // final List<Weekday>? weekdays;
  // @override
  // final String? description;
  // @override
  // final bool isLiked;
  // @override
  // final String? url;

  final String audio;

  @override
  String getWeekdays() {
    return "${weekdays?.map((el) => el.displayTitle).join(', ')}";
  }
}
