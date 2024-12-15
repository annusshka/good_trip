import 'dart:io';

import 'package:day_picker/day_picker.dart';
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
  final String imagePath;
  final List<DayInWeek> weekdays;
  final String description;
  final List<String> kinds;
  final Address address;
  final String audioPath;
  final File? imageFile;
  final File? audioFile;

  const ExcursionCreateRequested({
    required this.name,
    required this.imagePath,
    required this.weekdays,
    required this.description,
    required this.kinds,
    required this.address,
    required this.audioPath,
    required this.imageFile,
    required this.audioFile,
  });
}

class ExcursionUpdateParamsRequested extends ExcursionCreateEvent {
  final IExcursion tour;
  final String? name;
  final String? imagePath;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String>? kinds;
  final Address? address;
  final String? audioPath;
  final File? imageFile;
  final File? audioFile;

  const ExcursionUpdateParamsRequested({
    required this.tour,
    this.name,
    this.imagePath,
    this.weekdays,
    this.description,
    this.kinds,
    this.address,
    this.audioPath,
    this.imageFile,
    this.audioFile,
  });
}

class ExcursionUpdateAudioRequested extends ExcursionCreateEvent {}

class ExcursionUpdateImageRequested extends ExcursionCreateEvent {}

class ExcursionUpdateKindsRequested extends ExcursionCreateEvent {}

class ExcursionUpdateWeekdaysRequested extends ExcursionCreateEvent {}

class CreatedExcursionRemoveRequested extends ExcursionCreateEvent {
  final BuildContext context;
  final String tourId;

  const CreatedExcursionRemoveRequested({
    required this.context,
    required this.tourId,
  });
}
