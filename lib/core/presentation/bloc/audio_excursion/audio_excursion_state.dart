import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class AudioExcursionState extends Equatable {
  const AudioExcursionState();

  @override
  List<Object> get props => [];
}

class AudioExcursionInitial extends AudioExcursionState {}

class AudioExcursionLoadInProgress extends AudioExcursionState {}

class AudioExcursionLoadSuccess extends AudioExcursionState {
  final List<AudioExcursion> tourList;

  const AudioExcursionLoadSuccess({required this.tourList});

  @override
  List<Object> get props => [tourList];
}

class AudioExcursionLoadFailure extends AudioExcursionState {
  final String errorMsg;

  const AudioExcursionLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}