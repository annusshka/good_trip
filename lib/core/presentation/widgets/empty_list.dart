import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.lightGray,
      child: const Text(
        'Здесь пока пусто',
        style: AppTextTheme.normal16,
      ),
    );
  }
}
