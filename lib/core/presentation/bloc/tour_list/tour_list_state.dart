import 'package:equatable/equatable.dart';

import '../../../domain/models/models.dart';

abstract class TourListState extends Equatable {
  const TourListState();

  @override
  List<Object> get props => [];
}

class TourListInitial extends TourListState {}

class TourListLoadInProgress extends TourListState {}

class TourListLoadSuccess extends TourListState {
  final List<Tour> tourList;

  const TourListLoadSuccess({required this.tourList});

  @override
  List<Object> get props => [tourList];
}

class TourListLoadFailure extends TourListState {
  final String errorMsg;

  const TourListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}