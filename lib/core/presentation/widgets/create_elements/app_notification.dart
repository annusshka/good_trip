import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class AppNotification extends StatelessWidget {
  const AppNotification(
      {super.key, required this.text, this.title = 'Уведомление'});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Text(
        title,
        style: AppTextTheme.semiBold20,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              text,
              style: AppTextTheme.normal16,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            context.router.maybePop();
          },
          child: Text(
            'Ок',
            style: AppTextTheme.semiBold18.copyWith(
              color: AppColors.pink,
            ),
          ),
        ),
      ],
    );
  }
}
