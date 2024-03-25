import 'package:equatable/equatable.dart';

import '../../../domain/models/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

// When the user signing in with email and password this event is called and the [AuthRepository] is called to sign in the user
class SignInRequested extends AuthEvent {
  final User user;
  //final String email;
  //final String password;

  //const SignInRequested(this.email, this.password);
  const SignInRequested(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

// When the user signing up with email and password this event is called and the [AuthRepository] is called to sign up the user
class SignUpRequested extends AuthEvent {
  /*
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String password;

  const SignUpRequested(this.name, this.surname, this.email, this.phone, this.password);*/

  final User user;
  const SignUpRequested(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class SignOutRequested extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthLoadUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

/*
class AuthAuthenticateEvent extends AuthEvent {
  final User user;

  const AuthAuthenticateEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthLogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}*/