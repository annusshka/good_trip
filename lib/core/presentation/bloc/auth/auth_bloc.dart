import 'package:bloc/bloc.dart';

import '../../../domain/models/user.dart';
import '../../../domain/service/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoadingState()) {
    on<SignOutRequested>((event, emit) async {
      AuthService.logout();
      emit(AuthUnauthenticatedState());
    });

    on<AuthLoadUserEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        User user = await AuthService.loadUser();
        emit(AuthAuthenticatedState(user: user));
      } catch (e) {
        emit(AuthUnauthenticatedState());
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthAuthenticatedState(user: event.user));
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthAuthenticatedState(user: event.user));
    });

    add(AuthLoadUserEvent());
  }
}