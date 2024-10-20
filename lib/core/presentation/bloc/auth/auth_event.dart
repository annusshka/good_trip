import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final User user;
  const SignUpRequested(this.user);
}

class LogOutRequested extends AuthEvent {}

class AuthLoadUserEvent extends AuthEvent {}
