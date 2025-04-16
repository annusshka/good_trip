import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class ProfileInfo extends StatelessWidget {
  final User user;

  const ProfileInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        user.role.displayTitle,
        style: AppTextTheme.semiBold18,
      ),
      subtitle: Text(
        '${user.name} ${user.surname}',
        style: AppTextTheme.medium15,
      ),
    );
  }
}
