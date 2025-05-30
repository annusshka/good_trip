import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/buttons/buttons.dart';
import 'package:good_trip/core/presentation/widgets/create_elements/create_elements.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

@RoutePage()
class TourCreateScreen extends StatefulWidget {
  const TourCreateScreen({super.key});

  @override
  State<TourCreateScreen> createState() => _TourCreateScreenState();
}

class _TourCreateScreenState extends State<TourCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tourNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  List<DayInWeek>? weekdays;
  String? imagePath;
  File? imageFile;
  List<TourType>? kindList;

  @override
  void dispose() {
    _tourNameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        leading: const BackIconButton(
          color: Colors.black,
          iconSize: 24,
        ),
        title: const Text(
          'Создайте тур',
          style: AppTextTheme.semiBold26,
          //textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagePickerWidget(
                  onChooseImage: (String? path, File? file) {
                    imagePath = path;
                    imageFile = file;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _tourNameController,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: AppColors.gray,
                  cursorErrorColor: AppColors.red,
                  cursorRadius: const Radius.circular(3.0),
                  decoration: InputDecoration(
                    hintText: 'Название',
                    hintStyle: AppTextTheme.semiBold18.copyWith(
                      color: AppColors.lightGray,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: AppColors.lightGray,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: AppColors.lightGray,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.red,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.red,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorStyle: AppTextTheme.semiBold10,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: AppTextTheme.semiBold18.copyWith(
                    color: AppColors.gray,
                  ),
                  validator: (value) {
                    return value != null && value.length < 2
                        ? 'Название должно быть длиннее'
                        : null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                KindsMultiSelect(
                  onKindsSelected: (List<TourType> kinds) {
                    kindList = kinds;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                WeekdayWidget(
                  weekDaysSelect: (List<DayInWeek> weekdayList) {
                    weekdays = weekdayList;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _descriptionController,
                  cursorColor: AppColors.gray,
                  cursorErrorColor: AppColors.red,
                  cursorRadius: const Radius.circular(3.0),
                  decoration: InputDecoration(
                    hintText: 'Описание',
                    hintStyle: AppTextTheme.semiBold18.copyWith(
                      color: AppColors.lightGray,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: AppColors.lightGray,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: AppColors.lightGray,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.red,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.red,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorStyle: AppTextTheme.semiBold10,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: AppTextTheme.semiBold18.copyWith(
                    color: AppColors.gray,
                  ),
                  validator: (value) {
                    return value != null &&
                            value.length < 10 &&
                            value.length > 2000
                        ? 'Текст должен быть больше 10 и меньше 2000 символов'
                        : null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: AppColors.pink,
                    width: double.infinity,
                    height: height * 0.08,
                    child: TextButton(
                      onPressed: () {
                        final currentState = _formKey.currentState;
                        if (currentState != null && currentState.validate()) {
                          context.router.push(
                            TourCreateExcursionRoute(
                              name: _tourNameController.value.text,
                              description: _descriptionController.value.text,
                              kinds: kindList ?? [],
                              weekdays: weekdays ?? [],
                              imagePath: imagePath ?? '',
                              imageFile: imageFile,
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Далее',
                        style: AppTextTheme.semiBold18.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
