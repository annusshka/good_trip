import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

class ImagePickerWidget extends StatelessWidget {
  ImagePickerWidget({super.key, required this.onChooseImage});

  final ImageCubit cubit = ImageCubit();
  final Function(String? imagePath, File? imageFile) onChooseImage;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<ImageCubit, ImageState>(
      bloc: cubit,
      builder: (context, state) {
        final image = state.image;

        return GestureDetector(
          onTap: () {
            cubit.pickImageFromGallery();
            onChooseImage(state.imagePath, state.image);
          },
          child: SizedBox(
            height: height * 0.25,
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: image != null
                  ? Image.file(
                      image,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: AppColors.lightGray,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.file_upload_outlined,
                            color: AppColors.white,
                            size: 40,
                          ),
                          Text(
                            'Загрузите фотографию',
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
