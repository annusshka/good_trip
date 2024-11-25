import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class ExcursionCreateEvent extends Equatable {
  const ExcursionCreateEvent();

  @override
  List<Object> get props => [];
}

class ExcursionCreateRequested extends ExcursionCreateEvent {
  final String name;
  // final String imagePath;
  // final List<Weekday> weekdays;
  final String description;
  // final List<String> kinds;
  final Address address;
  // final String audioPath;
  // final File? imageFile;
  // final File? audioFile;

  const ExcursionCreateRequested({
    required this.name,
    // required this.imagePath,
    // required this.weekdays,
    required this.description,
    // required this.kinds,
    required this.address,
    // required this.audioPath,
    // required this.imageFile,
    // required this.audioFile,
  });
}

class CreatedExcursionRemoveRequested extends ExcursionCreateEvent {
  final BuildContext context;
  final String tourId;

  const CreatedExcursionRemoveRequested({
    required this.context,
    required this.tourId,
  });
}
