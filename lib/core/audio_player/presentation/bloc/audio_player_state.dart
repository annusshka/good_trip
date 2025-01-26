import 'package:equatable/equatable.dart';

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();

  @override
  List<Object> get props => [];
}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerIsLoading extends AudioPlayerState {}

class AudioPlayerLoadSuccess extends AudioPlayerState {}

class AudioPlayerLoadFailure extends AudioPlayerState {
  final String errorMsg;

  const AudioPlayerLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}