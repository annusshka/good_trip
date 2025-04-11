import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class TourState extends Equatable {
  const TourState();

  @override
  List<Object> get props => [];
}

class TourInitial extends TourState {}

class TourLoadInProgress extends TourState {}

class TourLoadSuccess extends TourState {}

class TourLikedSuccess extends TourState {}

class TourListLoadSuccess extends TourState {
  final List<Tour> tourList;

  const TourListLoadSuccess({required this.tourList});

  @override
  List<Object> get props => [tourList];
}

class TourListLoadFailure extends TourState {
  final String errorMsg;

  const TourListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}