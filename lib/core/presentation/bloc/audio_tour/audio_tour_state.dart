import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class AudioTourState extends Equatable {
  const AudioTourState();

  @override
  List<Object> get props => [];
}

class AudioTourInitial extends AudioTourState {}

class AudioTourLoadInProgress extends AudioTourState {}

class AudioTourLoadSuccess extends AudioTourState {
  final List<AudioTour> tourList;

  const AudioTourLoadSuccess({required this.tourList});

  @override
  List<Object> get props => [tourList];
}

class AudioTourLoadFailure extends AudioTourState {
  final String errorMsg;

  const AudioTourLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}