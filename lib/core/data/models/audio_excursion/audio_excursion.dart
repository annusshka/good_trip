import 'package:good_trip/core/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_excursion.g.dart';

@JsonSerializable()
class AudioExcursion extends IAudioExcursion {
  AudioExcursion({
    required String id,
    required String name,
    String? imageUrl,
    required Address address,
    List<Weekday>? weekdays,
    String? description,
    required List<String> kinds,
    bool isLiked = false,
    String? deeplinkUrl,
    required String audioUrl,
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
          audioUrl: audioUrl,
        );

  Map<String, dynamic> toJson() => _$AudioExcursionToJson(this);

  factory AudioExcursion.fromJson(Map<String, Object?> json) =>
      _$AudioExcursionFromJson(json);
}
