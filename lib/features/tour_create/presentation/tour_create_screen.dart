import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/features/tour_create/presentation/widgets/weekday_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/presentation/widgets/widgets.dart';
import '../../../core/theme/theme.dart';

@RoutePage()
class TourCreateScreen extends StatefulWidget {
  const TourCreateScreen({super.key});

  @override
  State<TourCreateScreen> createState() => _TourCreateScreenState();
}

class _TourCreateScreenState extends State<TourCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tourNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  bool isImageSelected = false;
  File? imageFile;

  @override
  void dispose() {
    _tourNameController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const BackIconButton(color: Colors.black, iconSize: 24,),
                  title: Text(
                    'Создайте экскурсию',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: height * 0.25,
                  width: width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: GestureDetector(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: isImageSelected
                          ? Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: colors.lightGray,
                              child: const Icon(
                                Icons.file_upload_outlined,
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _tourNameController,
                  decoration: InputDecoration(
                    hintText: "Название",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: colors.lightGray2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    counterStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value != null && value.length < 2
                        ? 'Название должно быть длиннее'
                        : null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: "Город",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: colors.lightGray2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    counterStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value != null && value.length < 2
                        ? 'Введите существующий город'
                        : null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: "Описание",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: colors.lightGray2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    counterStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  maxLines: 6,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value != null &&
                            value.length < 10 &&
                            value.length > 600
                        ? "Текст должен быть больше 10 и меньше 600 символов"
                        : null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const WeekdayWidget(),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: _dateController,
                  decoration: InputDecoration(
                    hintText: "Дата",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: colors.lightGray2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    counterStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value == null ? 'Введите дату' : null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: colors.pink_,
                    width: double.infinity,
                    height: height * 0.08,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text(
                        'Создать',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      } else {
        debugPrint("User didn't pick any image.");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
