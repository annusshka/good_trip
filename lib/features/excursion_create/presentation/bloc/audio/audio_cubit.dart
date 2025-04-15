import 'dart:io';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(const AudioState(audioPath: null, audio: null));

  Future<void> handleAudioFromFiles() async {
    try {
      FilePickerResult? audioFileResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav'],
      );

      late final File? pickedAudio;
      if (audioFileResult != null) {
        final String path = audioFileResult.files.single.path!;
        pickedAudio = File(path);
      } else {
        pickedAudio = null;
        debugPrint("User didn't pick any audio.");
      }

      emit(AudioState(audioPath: pickedAudio?.path, audio: pickedAudio));
    } catch (error) {
      debugPrint(error.toString());
      AppMetrica.reportErrorWithGroup(
        'ExcursionCreate level',
        message: error.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
