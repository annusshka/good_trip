import 'package:equatable/equatable.dart';

abstract class AccountListEvent extends Equatable {
  const AccountListEvent();

  @override
  List<Object> get props => [];
}

class AccountListRequested extends AccountListEvent {}

class AccountRemoveRequested extends AccountListEvent {
  final int accountId;

  const AccountRemoveRequested({required this.accountId});
}
