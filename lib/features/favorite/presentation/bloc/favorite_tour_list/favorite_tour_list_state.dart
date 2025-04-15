import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class FavoriteTourListState extends Equatable {
  const FavoriteTourListState();

  @override
  List<Object> get props => [];
}

class FavoriteTourListInitial extends FavoriteTourListState {}

class FavoriteTourListLoadInProgress extends FavoriteTourListState {}

class FavoriteTourListLoadedSuccess extends FavoriteTourListState {
  final List<ITour> tourList;

  const FavoriteTourListLoadedSuccess({required this.tourList});

  @override
  List<Object> get props => [tourList];
}

class FavoriteTourListLoadFailure extends FavoriteTourListState {
  final String errorMsg;

  const FavoriteTourListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}