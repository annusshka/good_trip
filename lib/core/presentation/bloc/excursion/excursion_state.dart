import 'package:equatable/equatable.dart';

abstract class ExcursionState extends Equatable {
  const ExcursionState();

  @override
  List<Object> get props => [];
}

class ExcursionInitial extends ExcursionState {}

class ExcursionLoadInProgress extends ExcursionState {}

class ExcursionLoadSuccess extends ExcursionState {}

class ExcursionLikedSuccess extends ExcursionState {}

class ExcursionListLoadFailure extends ExcursionState {
  final String errorMsg;

  const ExcursionListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}