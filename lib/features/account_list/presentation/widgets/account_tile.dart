import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/account_list/presentation/bloc/account_list.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({super.key, required this.account});

  final User account;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Iconsax.user_copy,
        color: AppColors.pink,
        size: 24,
      ),
      title: Text(
        '${account.name} ${account.surname}',
        style: AppTextTheme.normal16,
      ),
      trailing: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            color: AppColors.pink,
            child: TextButton(
              onPressed: () {
                BlocProvider.of<AccountListBloc>(context)
                    .add(AccountRemoveRequested(accountId: account.id));
              },
              child: Text(
                'Удалить',
                style: AppTextTheme.normal16.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
