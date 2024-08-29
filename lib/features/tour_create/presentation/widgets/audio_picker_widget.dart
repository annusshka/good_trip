import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class AudioPickerWidget extends StatefulWidget {
  const AudioPickerWidget({super.key, required this.func});

  final Function func;

  @override
  State<AudioPickerWidget> createState() => _AudioPickerWidgetState();
}

class _AudioPickerWidgetState extends State<AudioPickerWidget> {
  File? audioFile;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: height * 0.1,
      width: width,
      child: GestureDetector(
        onTap: handleAudioFromFiles,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // Image border
          child: audioFile != null
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.lightGrayEA),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.mic,
                        color: AppColors.darkGray,
                        size: 30,
                      ),
                      Expanded(
                        child: Text(
                          audioFile!.path.split('/').last,
                          style: AppTextTheme.semiBold18.copyWith(
                            color: AppColors.darkGray,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  color: AppColors.lightGray,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.mic,
                        color: AppColors.darkGray,
                        size: 30,
                      ),
                      Text(
                        'Загрузите аудиоэкскурсию',
                        style: AppTextTheme.semiBold18.copyWith(
                          color: AppColors.darkGray,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void handleAudioFromFiles() async {
    try {
      FilePickerResult? audioFileResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav'],
      );

      if (audioFileResult != null) {
        final String path = audioFileResult.files.single.path!;

        File pickedAudio = File(path);

        setState(() {
          audioFile = pickedAudio;
        });
        widget.func(audioFile);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
