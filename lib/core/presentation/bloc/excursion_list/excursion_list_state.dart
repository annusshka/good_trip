import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class ExcursionListState extends Equatable {
  const ExcursionListState();

  @override
  List<Object> get props => [];
}

class ExcursionListInitial extends ExcursionListState {}

class ExcursionListLoadInProgress extends ExcursionListState {}

class ExcursionListLoadSuccess extends ExcursionListState {
  final List<Excursion> excursionList;

  const ExcursionListLoadSuccess({required this.excursionList});

  @override
  List<Object> get props => [excursionList];
}

class ExcursionListLoadFailure extends ExcursionListState {
  final String errorMsg;

  const ExcursionListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}