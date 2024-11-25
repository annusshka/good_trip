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
  final String imagePath;
  final List<Weekday> weekdays;
  final String description;
  final List<String> kinds;
  final Address address;
  final List<IExcursion> excursionList;
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
  final BuildContext context;
  final String tourId;

  const CreatedTourRemoveRequested({
    required this.context,
    required this.tourId,
  });
}
