import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/widgets/buttons/buttons.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/di/configure_dependencies.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

import 'widgets/widgets.dart';

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

    return MultiBlocProvider(
      providers: [
        BlocProvider<ExcursionCreateBloc>(
          lazy: false,
          create: (_) => ExcursionCreateBloc(
            excursionRepository: getIt.get<IExcursionRepository>(),
          ),
        ),
      ],
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
                  ImagePickerWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _tourNameController,
                    decoration: const InputDecoration(
                      hintText: 'Название',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: AppTextTheme.normal16.copyWith(
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
                  const KindsMultiSelect(),
                  const SizedBox(
                    height: 10,
                  ),
                  AudioPickerWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    controller: _countryController,
                    decoration: const InputDecoration(
                      hintText: 'Страна',
                    ),
                    style: AppTextTheme.normal16.copyWith(
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
                    decoration: const InputDecoration(
                      hintText: 'Город',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: AppTextTheme.normal16.copyWith(
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
                    decoration: const InputDecoration(
                      hintText: 'Улица',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: AppTextTheme.normal16.copyWith(
                      color: AppColors.darkGray,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    controller: _houseController,
                    decoration: const InputDecoration(
                      hintText: 'Дом',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: AppTextTheme.normal16.copyWith(
                      color: AppColors.darkGray,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const WeekdayWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Описание',
                    ),
                    maxLines: 10,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: AppTextTheme.normal16.copyWith(
                      color: AppColors.darkGray,
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
                      child: BlocBuilder<ExcursionCreateBloc, ExcursionCreateState>(
                        builder: (context, state) {
                          // if (state is TourCreatedSuccess) {
                          //   BlocProvider.of<TourCreateListBloc>(context)
                          //       .add(const TourCreateListRequested());
                          // }
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
      ),
    );
  }
}
