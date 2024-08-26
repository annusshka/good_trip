import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/widgets/empty_list.dart';
import 'package:good_trip/core/theme/theme.dart';
import 'package:good_trip/features/account_list/presentation/widgets/account_tile.dart';

import 'bloc/account_list.dart';

@RoutePage()
class AccountListScreen extends StatelessWidget {
  const AccountListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: colors.pink_,
        automaticallyImplyLeading: false,
        title: Text(
          'Пользователи',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.merge(TextStyle(color: colors.white)),
        ),
      ),
      body: BlocBuilder<AccountListBloc, AccountListState>(
          builder: (context, state) {
        if (state is AccountListLoadSuccess) {
          if (state.accounts.isEmpty) {
            return const EmptyList();
          } else {
            return ListView.separated(
              padding: EdgeInsets.only(top: height * 0.02),
              scrollDirection: Axis.vertical,
              itemCount: state.accounts.length,
              separatorBuilder: (BuildContext context, _) => SizedBox(
                height: height * 0.03,
              ),
              itemBuilder: (context, i) {
                return AccountTile(
                  account: state.accounts[i],
                );
              },
            );
          }
        } else if (state is AccountListLoadFailure) {
          return const Center();
        } else if (state is AccountRemoveSuccess) {
          BlocProvider.of<AccountListBloc>(context)
              .add(AccountListRequested());
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
