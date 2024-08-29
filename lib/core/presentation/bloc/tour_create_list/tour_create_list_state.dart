import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class TourCreateListState extends Equatable {
  const TourCreateListState();

  @override
  List<Object> get props => [];
}

class TourCreateListInitial extends TourCreateListState {}

class TourCreateListLoadInProgress extends TourCreateListState {}

class TourCreateListLoadedSuccess extends TourCreateListState {
  final List<AudioTour> tourList;

  const TourCreateListLoadedSuccess({required this.tourList});

  @override
  List<Object> get props => [tourList];
}

class TourCreateListLoadFailure extends TourCreateListState {
  final String errorMsg;

  const TourCreateListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}