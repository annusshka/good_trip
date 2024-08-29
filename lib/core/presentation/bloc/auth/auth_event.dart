import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignUpRequested extends AuthEvent {
  final User user;
  const SignUpRequested(this.user);

  @override
  List<Object?> get props => [];
}

class LogOutRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthLoadUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
