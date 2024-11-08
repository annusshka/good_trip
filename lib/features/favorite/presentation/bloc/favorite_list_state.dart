import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class FavoriteListState extends Equatable {
  const FavoriteListState();

  @override
  List<Object> get props => [];
}

class FavoriteListInitial extends FavoriteListState {}

class FavoriteListLoadInProgress extends FavoriteListState {}

class FavoriteListLoadedSuccess extends FavoriteListState {
  final List<IExcursion> tourList;

  const FavoriteListLoadedSuccess({required this.tourList});

  @override
  List<Object> get props => [tourList];
}

class FavoriteListLoadFailure extends FavoriteListState {
  final String errorMsg;

  const FavoriteListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}