import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/excursion_create_list/excursion_create_list.dart';
import 'package:good_trip/core/presentation/widgets/buttons/buttons.dart';
import 'package:good_trip/core/presentation/widgets/create_elements/create_elements.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

@RoutePage()
class ExcursionCreateScreen extends StatefulWidget {
  const ExcursionCreateScreen({super.key});

  @override
  State<ExcursionCreateScreen> createState() => _ExcursionCreateScreenState();
}

class _ExcursionCreateScreenState extends State<ExcursionCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tourNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _houseController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  late List<Weekday> weekdays;
  late String? imagePath;
  late File? imageFile;
  late String? audioPath;
  late File? audioFile;
  late List<String> kindList;

  @override
  void dispose() {
    _tourNameController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _houseController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        leading: const BackIconButton(
          color: Colors.black,
          iconSize: 24,
        ),
        title: const Text(
          'Создайте экскурсию',
          style: AppTextTheme.semiBold26,
          textAlign: TextAlign.center,
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
                    hintText: 'Страна',
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
                  onKindsSelected: (List<String> kinds) {
                    kindList = kinds;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AudioPickerWidget(
                  onChooseAudio: (String? path, File? file) {
                    audioPath = path;
                    audioFile = file;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _countryController,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: AppColors.gray,
                  cursorErrorColor: AppColors.red,
                  cursorRadius: const Radius.circular(3.0),
                  decoration: InputDecoration(
                    hintText: 'Страна',
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
                        ? 'Введите страну'
                        : null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _cityController,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: AppColors.gray,
                  cursorErrorColor: AppColors.red,
                  cursorRadius: const Radius.circular(3.0),
                  decoration: InputDecoration(
                    hintText: 'Город',
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
                        ? 'Введите город'
                        : null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _streetController,
                  textCapitalization: TextCapitalization.words,
                  cursorColor: AppColors.gray,
                  cursorErrorColor: AppColors.red,
                  cursorRadius: const Radius.circular(3.0),
                  decoration: InputDecoration(
                    hintText: 'Улица',
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
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  controller: _houseController,
                  cursorColor: AppColors.gray,
                  cursorErrorColor: AppColors.red,
                  cursorRadius: const Radius.circular(3.0),
                  decoration: InputDecoration(
                    hintText: 'Дом',
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
                ),
                const SizedBox(
                  height: 10,
                ),
                WeekdayWidget(
                  weekDaysSelect: (List<Weekday> weekdayList) {
                    weekdays = weekdayList;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _descriptionController,
                  textCapitalization: TextCapitalization.words,
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
                    child:
                        BlocBuilder<ExcursionCreateBloc, ExcursionCreateState>(
                      builder: (context, state) {
                        if (state is ExcursionCreatedSuccess) {
                          BlocProvider.of<ExcursionCreateListBloc>(context)
                              .add(const ExcursionCreateListRequested());
                        }
                        return TextButton(
                          onPressed: () {
                            final currentState = _formKey.currentState;
                            if (currentState != null &&
                                currentState.validate()) {
                              BlocProvider.of<ExcursionCreateBloc>(context).add(
                                ExcursionCreateRequested(
                                  name: _tourNameController.value.text,
                                  description:
                                      _descriptionController.value.text,
                                  address: Address(
                                    country: _countryController.value.text,
                                    city: _cityController.value.text,
                                    street: _streetController.value.text,
                                    house: _houseController.value.text,
                                  ),
                                  imagePath: imagePath ?? '',
                                  weekdays: weekdays,
                                  kinds: kindList,
                                  audioPath: audioPath ?? '',
                                  imageFile: imageFile,
                                  audioFile: audioFile,
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Создать',
                            style: AppTextTheme.semiBold18.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
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
