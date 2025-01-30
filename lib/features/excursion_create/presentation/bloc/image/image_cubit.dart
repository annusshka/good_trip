import 'dart:io';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(const ImageState(imagePath: null, image: null));

  Future<void> pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      late final File? image;
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        image = null;
        debugPrint("User didn't pick any image.");
      }

      emit(ImageState(imagePath: pickedImage?.path, image: image));
    } catch (e) {
      debugPrint(e.toString());
      AppMetrica.reportErrorWithGroup(
        'ExcursionCreate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
