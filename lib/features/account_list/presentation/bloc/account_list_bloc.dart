import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/models/models.dart';
import '../../domain/service/account_service.dart';
import 'account_list.dart';

class AccountListBloc extends Bloc<AccountListEvent, AccountListState> {
  AccountListBloc() : super(AccountListInitial()) {
    on<AccountListEvent>(
      (event, emit) async {
        if (event is AccountListRequested) {
          await _getAccounts(event, emit);
        }
        if (event is AccountRemoveRequested) {
          await _removeAccount(event, emit);
        }
      },
    );
  }

  _getAccounts(
      AccountListRequested event, Emitter<AccountListState> emit) async {
    emit(AccountListLoadInProcess());
    try {
      final List<User> accounts = await AccountService().getAccountList();
      emit(AccountListLoadSuccess(accounts: accounts));
    } catch (e) {
      emit(AccountListLoadFailure(errorMsg: e.toString()));
    }
  }

  _removeAccount(
      AccountRemoveRequested event, Emitter<AccountListState> emit) async {
    emit(AccountListLoadInProcess());
    try {
      await AccountService().removeAccount(event.accountId);
      emit(AccountRemoveSuccess());
    } catch (e) {
      emit(AccountListLoadFailure(errorMsg: e.toString()));
    }
  }
}
