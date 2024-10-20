import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class TourCreateState extends Equatable {
  const TourCreateState();

  @override
  List<Object> get props => [];
}

class TourCreateInitial extends TourCreateState {}

class TourCreateInProgress extends TourCreateState {}

class TourUpdateParamSuccess extends TourCreateState {
  final ITour tour;

  const TourUpdateParamSuccess({required this.tour});

  @override
  List<Object> get props => [tour];
}

class TourCreatedSuccess extends TourCreateState {}

class TourRemovedSuccess extends TourCreateState {}

class TourCreateFailure extends TourCreateState {
  final String errorMsg;

  const TourCreateFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
