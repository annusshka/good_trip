import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class TourCreateEvent extends Equatable {
  const TourCreateEvent();

  @override
  List<Object> get props => [];
}

class TourCreateRequested extends TourCreateEvent {
  final String name;
  // final String imagePath;
  // final List<Weekday> weekdays;
  final String description;
  // final List<String> kinds;
  final Address address;
  // final String audioPath;
  // final File? imageFile;
  // final File? audioFile;

  const TourCreateRequested({
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

class TourUpdateParamsRequested extends TourCreateEvent {
  final ITour tour;
  final String? name;
  final String? imagePath;
  final List<Weekday>? weekdays;
  final String? description;
  final List<String>? kinds;
  final Address? address;
  final String? audioPath;
  final File? imageFile;
  final File? audioFile;

  const TourUpdateParamsRequested({
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

class TourUpdateAudioRequested extends TourCreateEvent {}

class TourUpdateImageRequested extends TourCreateEvent {}

class TourUpdateKindsRequested extends TourCreateEvent {}

class TourUpdateWeekdaysRequested extends TourCreateEvent {}

class CreatedTourRemoveRequested extends TourCreateEvent {
  final BuildContext context;
  final String tourId;

  const CreatedTourRemoveRequested({
    required this.context,
    required this.tourId,
  });
}
