import 'dart:io';

import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, required this.func});

  final Function func;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: height * 0.25,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Image border
        child: GestureDetector(
          onTap: _pickImageFromGallery,
          child: image != null
              ? Image.file(
                  image!,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: AppColors.lightGray,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.file_upload_outlined,
                        color: AppColors.darkGray,
                        size: 40,
                      ),
                      Text(
                        'Загрузите фотографию',
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

  void _pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          image = File(pickedImage.path);
        });
        widget.func(image);
      } else {
        debugPrint("User didn't pick any image.");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
