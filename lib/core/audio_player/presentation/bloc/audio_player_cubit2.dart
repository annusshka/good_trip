import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_player.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration audioDuration = Duration.zero;
  Duration audioPosition = Duration.zero;
  Duration audioBufferedPosition = Duration.zero;

  AudioPlayerCubit() : super(AudioPlayerInitial()) {
    audioPlayer.positionStream.listen((position) {
      audioPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      audioDuration = duration!;
    });
  }

  void updateSongPlayer() {
    emit(AudioPlayerIsLoading());
    emit(AudioPlayerLoadSuccess());
  }

  Future<void> loadSong({required String url}) async {
    emit(AudioPlayerIsLoading());
    try {
      audioPlayer.setLoopMode(LoopMode.one);
      await audioPlayer.setUrl(url);
      emit(AudioPlayerLoadSuccess());
    } catch (e) {
      emit(AudioPlayerLoadFailure(errorMsg: e.toString()));
    }
  }

  void playOrPauseSong() {
    emit(AudioPlayerIsLoading());
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    emit(AudioPlayerLoadSuccess());
  }

  void playAudio() {
    audioPlayer.play();
  }

  void stopAudio() {
    audioPlayer.stop();
  }

  void replay() {
    audioPlayer.seek(
      Duration.zero,
      index: audioPlayer.effectiveIndices!.first,
    );
  }

  void updatePosition(Duration newPosition) {
    emit(AudioPlayerIsLoading());
    audioPlayer.seek(newPosition);
    emit(AudioPlayerLoadSuccess());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
