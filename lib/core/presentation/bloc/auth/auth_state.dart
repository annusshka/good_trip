import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  final User user;

  const AuthenticatedState({required this.user});
}

class AuthErrorState extends AuthState {
  final String error;

  const AuthErrorState(this.error);

  @override
  List<Object> get props => [error];
}