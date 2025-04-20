import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:day_picker/day_picker.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/audio_player/excursion_list/widgets/widgets.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/bloc.dart';
import 'package:good_trip/core/presentation/widgets/buttons/buttons.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion_create_list/presentation/widgets/excursion_list.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/create_excursion_list/create_excursion_list.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create/tour_create.dart';
import 'package:good_trip/features/tour_create/presentation/widgets/add_excursion_card.dart';
import 'package:good_trip/features/tour_create/presentation/widgets/excursion_card_list.dart';

@RoutePage()
class TourCreateExcursionScreen extends StatefulWidget {
  const TourCreateExcursionScreen({
    super.key,
    required this.name,
    required this.description,
    required this.kinds,
    required this.weekdays,
    required this.imagePath,
    required this.imageFile,
  });

  final String name;
  final String description;
  final String imagePath;
  final File? imageFile;
  final List<TourType> kinds;
  final List<DayInWeek> weekdays;

  @override
  State<TourCreateExcursionScreen> createState() => _TourCreateExcursionScreenState();
}

class _TourCreateExcursionScreenState extends State<TourCreateExcursionScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final cubit = context.read<CreateExcursionListCubit>();

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
          'Добавьте экскурсии',
          style: AppTextTheme.semiBold26,
          //textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              //vertical: 8.0,
            ),
            child: BlocBuilder<CreateExcursionListCubit, CreateExcursionListState>(
              bloc: cubit,
              builder: (context2, state) {
                return Column(
                  children: [
                    ExcursionCardList(
                      excursionList: state.excursionList,
                      tourName: 'new_${widget.name}',
                      onTapAction: (newExcursion) {
                        cubit.createExcursionList(
                          newExcursion as AudioExcursion,
                        );
                        context.router.maybePop();
                      },
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        color: AppColors.pink,
                        width: double.infinity,
                        height: height * 0.08,
                        child: BlocConsumer<TourCreateBloc, TourCreateState>(
                          listener: (context3, tourCreateState2) async {
                            if (tourCreateState2 is TourCreatedSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppColors.pink,
                                  content: Text(
                                    'Ваш тур успешно создан',
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                              );
                              await context.router.maybePop();
                              await context.router.maybePop();
                            }
                            if (tourCreateState2 is TourCreateFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppColors.pink,
                                  content: Text(
                                    'Ошибка при создании тура',
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                              );
                            }
                          },
                          builder: (context1, tourCreateState) {
                            if (tourCreateState is TourCreateInProgress) {
                              return TextButton(
                                onPressed: () {},
                                child: const CircularProgressIndicator(
                                  color: AppColors.white,
                                ),
                              );
                            }
                            return TextButton(
                              onPressed: () {
                                if (state.excursionList.isNotEmpty) {
                                  BlocProvider.of<TourCreateBloc>(context1).add(
                                    TourCreateRequested(
                                      name: widget.name,
                                      description: widget.description,
                                      address: state.excursionList[0].address,
                                      kinds: widget.kinds,
                                      imagePath: widget.imagePath,
                                      imageFile: widget.imageFile,
                                      weekdays: widget.weekdays,
                                      excursionList: state.excursionList,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
