import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart';

import 'account_list.dart';

class AccountListBloc extends Bloc<AccountListEvent, AccountListState> {
  final IAccountListRepository accountListRepository;

  AccountListBloc({required this.accountListRepository}) : super(AccountListInitial()) {
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

  Future<void> _getAccounts(
      AccountListRequested event, Emitter<AccountListState> emit) async {
    emit(AccountListLoadInProcess());
    try {
      final List<User> accounts = await accountListRepository.getAccountList();
      emit(AccountListLoadSuccess(accounts: accounts));
    } catch (e) {
      emit(AccountListLoadFailure(errorMsg: e.toString()));
    }
  }

  Future<void> _removeAccount(
      AccountRemoveRequested event, Emitter<AccountListState> emit) async {
    emit(AccountListLoadInProcess());
    try {
      await accountListRepository.removeAccount(accountId: event.accountId);
      emit(AccountRemoveSuccess());
    } catch (e) {
      emit(AccountListLoadFailure(errorMsg: e.toString()));
    }
  }
}
