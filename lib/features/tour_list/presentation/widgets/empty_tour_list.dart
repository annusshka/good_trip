import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class EmptyTourList extends StatelessWidget {
  const EmptyTourList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.pink.withValues(alpha: 0.2),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(
          color: AppColors.pink,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'В этом месте пока нет аудиотуров. Будьте первым!',
            style: AppTextTheme.normal16.copyWith(color: AppColors.pink),
            textAlign: TextAlign.center,
          ),
          // InkWell(
          //   onTap: () {
          //     context.router.push(const CreatedExcursionsRoute());
          //   },
          //   child: Container(
          //     height: 60.0,
          //     width: 220.0,
          //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //     decoration: const BoxDecoration(
          //       color: AppColors.pink,
          //       borderRadius: BorderRadius.all(Radius.circular(16.0)),
          //     ),
          //     child: const Center(
          //       child: Text(
          //         'Создать аудиоэкскурсию',
          //         style: AppTextTheme.normal15,
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
