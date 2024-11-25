import 'package:equatable/equatable.dart';

abstract class ExcursionCreateState extends Equatable {
  const ExcursionCreateState();

  @override
  List<Object> get props => [];
}

class ExcursionCreateInitial extends ExcursionCreateState {}

class ExcursionCreateInProgress extends ExcursionCreateState {}

class ExcursionCreatedSuccess extends ExcursionCreateState {}

class ExcursionRemovedSuccess extends ExcursionCreateState {}

class ExcursionCreateFailure extends ExcursionCreateState {
  final String errorMsg;

  const ExcursionCreateFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
