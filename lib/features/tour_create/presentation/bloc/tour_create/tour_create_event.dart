import 'dart:io';

import 'package:day_picker/day_picker.dart';
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
  final String imagePath;
  final List<DayInWeek> weekdays;
  final String description;
  final List<TourType> kinds;
  final Address address;
  final List<AudioExcursion> excursionList;
  final File? imageFile;

  const TourCreateRequested({
    required this.name,
    required this.imagePath,
    required this.weekdays,
    required this.description,
    required this.kinds,
    required this.address,
    required this.excursionList,
    required this.imageFile,
  });
}

class CreatedTourRemoveRequested extends TourCreateEvent {
  final String tourId;

  const CreatedTourRemoveRequested({
    required this.tourId,
  });
}
