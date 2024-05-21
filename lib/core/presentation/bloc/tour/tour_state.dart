import 'package:equatable/equatable.dart';

abstract class TourState extends Equatable {
  const TourState();

  @override
  List<Object> get props => [];
}

class TourInitial extends TourState {}

class TourLoadInProgress extends TourState {}

class TourLoadSuccess extends TourState {}

class TourLikedSuccess extends TourState {}

class TourListLoadFailure extends TourState {
  final String errorMsg;

  const TourListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}