import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

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
        onTap: () {
          handleAudioFromFiles();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // Image border
          child: audioFile != null
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: colors.lightGray2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.mic,
                        color: colors.darkGray,
                        size: 30,
                      ),
                      Expanded(
                        child: Text(
                          audioFile!.path.split('/').last,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.merge(TextStyle(color: colors.darkGray)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  color: colors.lightGray,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.mic,
                        color: colors.darkGray,
                        size: 30,
                      ),
                      Text(
                        "Загрузите аудиоэкскурсию",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.merge(TextStyle(
                              color: colors.darkGray,
                            )),
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
