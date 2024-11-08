import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class ExcursionCreateState extends Equatable {
  const ExcursionCreateState();

  @override
  List<Object> get props => [];
}

class ExcursionCreateInitial extends ExcursionCreateState {}

class ExcursionCreateInProgress extends ExcursionCreateState {}

class ExcursionUpdateParamSuccess extends ExcursionCreateState {
  final IExcursion tour;

  const ExcursionUpdateParamSuccess({required this.tour});

  @override
  List<Object> get props => [tour];
}

class ExcursionCreatedSuccess extends ExcursionCreateState {}

class ExcursionRemovedSuccess extends ExcursionCreateState {}

class ExcursionCreateFailure extends ExcursionCreateState {
  final String errorMsg;

  const ExcursionCreateFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
