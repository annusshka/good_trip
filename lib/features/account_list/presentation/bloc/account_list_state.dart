import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class AccountListState extends Equatable {
  const AccountListState();

  @override
  List<Object> get props => [];
}

class AccountListInitial extends AccountListState {}

class AccountListLoadInProcess extends AccountListState {}

class AccountListLoadSuccess extends AccountListState {
  final List<User> accounts;

  const AccountListLoadSuccess({required this.accounts});
}

class AccountRemoveSuccess extends AccountListState {}

class AccountListLoadFailure extends AccountListState {
  final String errorMsg;

  const AccountListLoadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}