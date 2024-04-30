import 'package:equatable/equatable.dart';

import '../../../domain/models/models.dart';

abstract class AudioTourState extends Equatable {
  const AudioTourState();

  @override
  List<Object> get props => [];
}

class AudioTourInitial extends AudioTourState {}

class AudioTourLoadInProgress extends AudioTourState {}

class AudioTourLoadSuccess extends AudioTourState {
  final List<Tour> tourList;

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