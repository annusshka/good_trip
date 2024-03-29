import 'package:equatable/equatable.dart';

import '../../../domain/models/models.dart';

abstract class TourState extends Equatable {
  const TourState();

  @override
  List<Object> get props => [];
}

class TourInitial extends TourState {}

class TourLoadInProgress extends TourState {}

class TourLoadSuccess extends TourState {
  final List<Tour> tourList;

  const TourLoadSuccess({required this.tourList});

  @override
  List<Object> get props => [tourList];
}

class TourLoadFailure extends TourState {
  final String errorMsg;

  const TourLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}