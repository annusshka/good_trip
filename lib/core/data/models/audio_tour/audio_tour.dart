import 'package:good_trip/core/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_tour.g.dart';

@JsonSerializable()
class AudioTour extends IAudioTour {
  AudioTour({
    required String id,
    required String name,
    String? image,
    required Address address,
    List<Weekday>? weekdays,
    String? description,
    required List<String> kinds,
    bool isLiked = false,
    String? url,
    required String audio,
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
          audio: audio,
        );

  Map<String, dynamic> toJson() => _$AudioTourToJson(this);

  factory AudioTour.fromJson(Map<String, Object?> json) =>
      _$AudioTourFromJson(json);
}
