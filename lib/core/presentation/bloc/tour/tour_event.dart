import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class TourEvent extends Equatable {
  const TourEvent();
}

class TourRequested extends TourEvent {
  final Tour tour;

  const TourRequested({required this.tour});

  @override
  List<Object> get props => [tour];
}

class TourLikeRequested extends TourEvent {
  final String id;

  const TourLikeRequested({required this.id});

  @override
  List<Object> get props => [id];
}

class TourSaveRequested extends TourEvent {
  final Tour tour;

  const TourSaveRequested({required this.tour});

  @override
  List<Object> get props => [tour];
}
