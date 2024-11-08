import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class ExcursionCreateListState extends Equatable {
  const ExcursionCreateListState();

  @override
  List<Object> get props => [];
}

class ExcursionCreateListInitial extends ExcursionCreateListState {}

class ExcursionCreateListLoadInProgress extends ExcursionCreateListState {}

class ExcursionCreateListLoadedSuccess extends ExcursionCreateListState {
  final List<AudioExcursion> excursionList;

  const ExcursionCreateListLoadedSuccess({required this.excursionList});

  @override
  List<Object> get props => [excursionList];
}

class ExcursionCreateListLoadFailure extends ExcursionCreateListState {
  final String errorMsg;

  const ExcursionCreateListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}