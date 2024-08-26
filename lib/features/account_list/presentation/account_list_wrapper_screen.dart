import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/di/configure_dependencies.dart';
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart';
import 'package:good_trip/features/account_list/presentation/bloc/account_list.dart';

@RoutePage()
class AccountListWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const AccountListWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountListBloc>(
          lazy: false,
          create: (_) => AccountListBloc(
            accountListRepository: getIt.get<IAccountListRepository>(),
          )..add(AccountListRequested()),
        ),
      ],
      child: this,
    );
  }
}
