import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class FavoriteExcursionListState extends Equatable {
  const FavoriteExcursionListState();

  @override
  List<Object> get props => [];
}

class FavoriteExcursionListInitial extends FavoriteExcursionListState {}

class FavoriteExcursionListLoadInProgress extends FavoriteExcursionListState {}

class FavoriteExcursionListLoadedSuccess extends FavoriteExcursionListState {
  final List<IExcursion> excursionList;

  const FavoriteExcursionListLoadedSuccess({required this.excursionList});

  @override
  List<Object> get props => [excursionList];
}

class FavoriteExcursionListLoadFailure extends FavoriteExcursionListState {
  final String errorMsg;

  const FavoriteExcursionListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}