import 'package:equatable/equatable.dart';

abstract class ViewedExcursionsState extends Equatable {
  const ViewedExcursionsState();

  @override
  List<Object> get props => [];
}

class ViewedExcursionsInitial extends ViewedExcursionsState {}

class ViewedExcursionsLoadInProgress extends ViewedExcursionsState {}

class LoadViewedExcursionsSuccess extends ViewedExcursionsState {
  final int excursionCount;

  const LoadViewedExcursionsSuccess({required this.excursionCount});

  @override
  List<Object> get props => [excursionCount];
}

class ViewedExcursionsLoadFailure extends ViewedExcursionsState {
  final String errorMsg;

  const ViewedExcursionsLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}