import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class AudioExcursionListState extends Equatable {
  const AudioExcursionListState();

  @override
  List<Object> get props => [];
}

class AudioExcursionListInitial extends AudioExcursionListState {}

class AudioExcursionListLoadInProgress extends AudioExcursionListState {}

class AudioExcursionListLoadSuccess extends AudioExcursionListState {
  final List<AudioExcursion> tourList;

  const AudioExcursionListLoadSuccess({required this.tourList});

  @override
  List<Object> get props => [tourList];
}

class AudioExcursionListLoadFailure extends AudioExcursionListState {
  final String errorMsg;

  const AudioExcursionListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}