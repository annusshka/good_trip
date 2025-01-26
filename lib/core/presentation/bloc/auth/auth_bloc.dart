import 'package:bloc/bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthLoadingState()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LogOutRequested) {
          await _logout(event, emit);
        }
        if (event is AuthLoadUserEvent) {
          await _loadUser(event, emit);
        }
        if (event is SignInRequested) {
          await _signIn(event, emit);
        }
        if (event is SignUpRequested) {
          await _signUp(event, emit);
        }
      },
    );

    add(AuthLoadUserEvent());
  }

  Future<void> _logout(LogOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await authRepository.logout();
      emit(UnauthenticatedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _loadUser(
      AuthLoadUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User user = await authRepository.loadUser();
      emit(AuthenticatedState(user: user));
    } catch (e) {
      emit(UnauthenticatedState());
    }
  }

  Future<void> _signIn(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User user = await authRepository.login(
        loginRequest: LoginRequest(
          email: event.email,
          password: event.password,
        ),
      );
      emit(AuthenticatedState(user: user));
    } catch (e) {
      emit(UnauthenticatedState());
    }
  }

  Future<void> _signUp(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User user = await authRepository.register(
        authRequest: AuthRequest(
          email: event.user.email,
          password: event.user.password,
          phone: event.user.phone,
          name: event.user.name,
          surname: event.user.surname,
        ),
      );
      emit(AuthenticatedState(user: user));
    } catch (e) {
      emit(UnauthenticatedState());
    }
  }
}
