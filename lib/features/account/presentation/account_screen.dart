import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/features/account/presentation/widgets/profile_info.dart';
import 'package:good_trip/features/account/presentation/widgets/profile_settings_list.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProfileInfo(
              account: Account(name: 'Ann', surname: 'Telegina',
                  accessLevel: AccessLevel.user)
          ),
          ListView(
            shrinkWrap: true,
            children: const [
              ProfileSettingsList(
                title: 'Аккаунт',
                elementList: ['Персональная информация', 'Изменить пароль',
                  'Стать экскурсоводом'],
              ),
              ProfileSettingsList(
                title: 'Поддержка',
                elementList: ['Связаться с поддержкой', 'Privacy policy'],
              ),
              ProfileSettingsList(
                title: 'Другое',
                elementList: ['Выйти'],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
