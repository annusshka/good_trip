import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/excursion/i_excursion.dart';
import 'package:good_trip/core/presentation/bloc/excursion_create_list/excursion_create_list.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddExcursionCard extends StatelessWidget {
  const AddExcursionCard({super.key, this.onTapAction});

  final Function(IExcursion)? onTapAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Container(
              height: 280,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                color: AppColors.white,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        const Spacer(),
                        Container(
                          height: 2.0,
                          width: 26.0,
                          color: AppColors.pink,
                          alignment: Alignment.center,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1,),
                  Flexible(
                    flex: 13,
                    child: BlocBuilder<ExcursionCreateListBloc,
                        ExcursionCreateListState>(
                      builder: (context, state) {
                        if (state is ExcursionCreateListLoadedSuccess) {
                          if (state.excursionList.isEmpty) {
                            return const EmptyList();
                          }
                          return ExcursionScrollList(
                            tourList: state.excursionList,
                            title: 'Мои экскурсии',
                            onTapAction: onTapAction,
                          );
                        }
                        if (state is ExcursionCreateListLoadInProgress) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGray.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(3, 5), // changes position of shadow
            ),
          ],
          color: AppColors.white,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add,
              color: AppColors.lightGray,
            ),
            Text(
              'Добавьте новую экскурсию',
              style: AppTextTheme.semiBold16,
            ),
          ],
        ),
      ),
    );
  }
}
