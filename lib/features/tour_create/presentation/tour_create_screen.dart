import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/tour_create_list/tour_create_list.dart';
import 'package:good_trip/core/presentation/widgets/buttons/buttons.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/core/theme/strings.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';

import 'widgets/widgets.dart';

@RoutePage()
class TourCreateScreen extends StatefulWidget {
  const TourCreateScreen({super.key});

  @override
  State<TourCreateScreen> createState() => _TourCreateScreenState();
}

class _TourCreateScreenState extends State<TourCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tourNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _houseController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  List<String> tourKinds = [];
  List<Weekday> weekdays = [];
  final List<DayInWeek> _days = [
    DayInWeek(
      'Пн',
      dayKey: Weekday.monday.name,
    ),
    DayInWeek('Вт', dayKey: Weekday.tuesday.name),
    DayInWeek(
      'Ср',
      dayKey: Weekday.wednesday.name,
    ),
    DayInWeek(
      'Чт',
      dayKey: Weekday.thursday.name,
    ),
    DayInWeek(
      'Пт',
      dayKey: Weekday.friday.name,
    ),
    DayInWeek(
      'Сб',
      dayKey: Weekday.saturday.name,
    ),
    DayInWeek(
      'Вс',
      dayKey: Weekday.sunday.name,
    ),
  ];
  File? imageFile;
  File? audioFile;

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

  InputDecoration getDecoration(String text) {
    return InputDecoration(
      hintText: text,
      hintStyle: AppTextTheme.normal16,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: AppColors.lightGrayEA),
        borderRadius: BorderRadius.circular(16),
      ),
      counterStyle: AppTextTheme.normal16,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    return BlocListener<TourCreateBloc, TourCreateState>(
      listener: (BuildContext context, TourCreateState state) {
        if (state is TourCreatedSuccess) {
          _showChangeNotification(context, changesSuccess);
          BlocProvider.of<TourCreateListBloc>(context)
              .add(const TourCreateListRequested());
        }
        if (state is TourCreateFailure) {
          _showChangeNotification(context, changesFail);
        }
      },
      child: Scaffold(
          appBar: AppBar(
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
                    ImagePickerWidget(func: pickImage),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _tourNameController,
                      decoration: getDecoration('Название'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: AppTextTheme.semiBold18.copyWith(
                        color: AppColors.darkGray,
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
                    KindsMultiSelect(func: pickKinds),
                    const SizedBox(
                      height: 10,
                    ),
                    AudioPickerWidget(
                      func: pickAudio,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      controller: _countryController,
                      decoration: getDecoration('Страна'),
                      style: AppTextTheme.semiBold18.copyWith(
                        color: AppColors.darkGray,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      decoration: getDecoration('Город'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: AppTextTheme.semiBold18.copyWith(
                        color: AppColors.darkGray,
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
                      decoration: getDecoration('Улица'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: AppTextTheme.semiBold18.copyWith(
                        color: AppColors.darkGray,
                      ),
                      // validator: (value) {
                      //   return value != null && value.length < 2
                      //       ? 'Введите улицу'
                      //       : null;
                      // },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      controller: _houseController,
                      decoration: getDecoration('Дом'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: AppTextTheme.semiBold18.copyWith(
                        color: AppColors.darkGray,
                      ),
                      // validator: (value) {
                      //   return value != null && value.length < 2
                      //       ? 'Введите дом'
                      //       : null;
                      // },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    WeekdayWidget(
                      days: _days,
                      func: pickWeekdays,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _descriptionController,
                      decoration: getDecoration('Описание'),
                      maxLines: 6,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: AppTextTheme.semiBold18.copyWith(
                        color: AppColors.darkGray,
                      ),
                      validator: (value) {
                        return value != null &&
                                value.length < 10 &&
                                value.length > 600
                            ? 'Текст должен быть больше 10 и меньше 600 символов'
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
                        child: BlocBuilder<TourCreateBloc, TourCreateState>(
                            builder: (context, state) {
                          return TextButton(
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate() &&
                                  imageFile != null &&
                                  audioFile != null &&
                                  weekdays.isNotEmpty &&
                                  tourKinds.isNotEmpty) {
                                BlocProvider.of<TourCreateBloc>(context).add(
                                    TourCreateRequested(
                                        name: _tourNameController.value.text,
                                        imagePath: imageFile!.path,
                                        weekdays: weekdays,
                                        description:
                                            _descriptionController.value.text,
                                        kinds: tourKinds,
                                        address: Address(
                                            country:
                                                _countryController.value.text,
                                            city: _cityController.value.text,
                                            street:
                                                _streetController.value.text,
                                            house: _houseController.value.text),
                                        audioPath: audioFile!.path,
                                        imageFile: imageFile!,
                                        audioFile: audioFile!));
                                clearWeekdays();
                                //AutoRouter.of(context).pop();
                              }
                            },
                            child: Text(
                              'Создать',
                              style: AppTextTheme.semiBold18.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void pickKinds(List<String> kinds) {
    setState(() {
      tourKinds = kinds;
    });
  }

  void pickImage(File image) {
    setState(() {
      imageFile = image;
    });
  }

  void pickAudio(File audio) {
    setState(() {
      audioFile = audio;
    });
  }

  void pickWeekdays(List<Weekday> weekdayList) {
    setState(() {
      weekdays = weekdayList;
    });
  }

  void clearWeekdays() {
    for (final DayInWeek day in _days) {
      day.isSelected = false;
    }
  }

  Future<void> _showChangeNotification(context, String text) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppNotification(text: text);
      },
    );
  }
}
