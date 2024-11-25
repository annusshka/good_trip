import 'package:equatable/equatable.dart';

abstract class TourCreateState extends Equatable {
  const TourCreateState();

  @override
  List<Object> get props => [];
}

class TourCreateInitial extends TourCreateState {}

class TourCreateInProgress extends TourCreateState {}

class TourCreatedSuccess extends TourCreateState {}

class TourRemovedSuccess extends TourCreateState {}

class TourCreateFailure extends TourCreateState {
  final String errorMsg;

  const TourCreateFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
