import 'package:good_trip/core/data/models/models.dart';

abstract class IAudioExcursion extends IExcursion {

  IAudioExcursion({
    required String id,
    required String name,
    String? imageUrl,
    required Address address,
    List<Weekday>? weekdays,
    String? description,
    required List<String> kinds,
    bool isLiked = false,
    String? deeplinkUrl,
    required this.audioUrl,
  }) : super(
    id: id,
    name: name,
    imageUrl: imageUrl,
    address: address,
    weekdays: weekdays,
    description: description,
    kinds: kinds,
    isLiked: isLiked,
    deeplinkUrl: deeplinkUrl,
  );

  final String audioUrl;

  @override
  String getWeekdays() {
    return "${weekdays?.map((el) => el.displayTitle).join(', ')}";
  }
}
