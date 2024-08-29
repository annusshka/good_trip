import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class ProfileSettingsList extends StatelessWidget {
  final String title;
  final List<String> elementList;
  const ProfileSettingsList({super.key,
    required this.title, required this.elementList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(title, style: AppTextTheme.semiBold18, ),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(elementList[i],
                style: AppTextTheme.normal16,
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                size: 24,
                color: AppColors.gray,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.lightGrayF5,
          ),
          itemCount: elementList.length,
        )
      ],
    );
  }
}
