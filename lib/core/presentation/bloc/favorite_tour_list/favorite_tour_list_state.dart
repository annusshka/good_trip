import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class FavoriteTourListState extends Equatable {
  final List<ITour>? tourList;

  const FavoriteTourListState({required this.tourList});

  @override
  List<Object?> get props => [tourList];
}

class FavoriteTourListInitial extends FavoriteTourListState {
  const FavoriteTourListInitial() : super(tourList: null);
}

class FavoriteTourListLoadInProgress extends FavoriteTourListState {
  const FavoriteTourListLoadInProgress() : super(tourList: null);
}

class FavoriteTourListLoadedSuccess extends FavoriteTourListState {
  const FavoriteTourListLoadedSuccess({required super.tourList});
}

class FavoriteTourListLoadFailure extends FavoriteTourListState {
  final String errorMsg;

  const FavoriteTourListLoadFailure({required this.errorMsg}) : super(tourList: const []);

  @override
  List<Object> get props => [errorMsg];
}