import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class TourTile extends StatelessWidget {
  const TourTile({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.icon,
  });

  final String? titleText;
  final String subtitleText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return titleText != null && titleText!.isNotEmpty
        ? ListTile(
            contentPadding: const EdgeInsets.only(right: 40),
            leading: Icon(
              icon,
              color: Colors.black,
              size: 24,
            ),
            title: Text(
              titleText!,
              textAlign: TextAlign.left,
              style: AppTextTheme.medium14.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              subtitleText,
              textAlign: TextAlign.left,
              style: AppTextTheme.medium14.copyWith(
                color: AppColors.lightGray,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Center(
                  child: Text(
                    subtitleText,
                    textAlign: TextAlign.left,
                    style: AppTextTheme.medium14.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
