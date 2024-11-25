import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

class AudioPickerWidget extends StatelessWidget {
  AudioPickerWidget({super.key, required this.onChooseAudio});

  final Function(String? path, File? file) onChooseAudio;
  final AudioCubit cubit = AudioCubit();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<AudioCubit, AudioState>(
      bloc: cubit,
      builder: (context, state) {
        final audioFile = state.audio;

        return GestureDetector(
          onTap: () {
            cubit.handleAudioFromFiles();
            onChooseAudio(state.audioPath, state.audio);
          },
          child: SizedBox(
            height: height * 0.1,
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // Image border
              child: audioFile != null
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.lightGrayEA,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.mic,
                            color: AppColors.white,
                            size: 30,
                          ),
                          Expanded(
                            child: Text(
                              audioFile.path.split('/').last,
                              style: AppTextTheme.semiBold18.copyWith(
                                color: AppColors.white,
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
                            color: AppColors.white,
                            size: 30,
                          ),
                          Text(
                            'Загрузите аудиоэкскурсию',
                            style: AppTextTheme.semiBold18.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
