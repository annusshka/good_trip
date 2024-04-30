import 'package:bloc/bloc.dart';

import '../../../domain/models/models.dart';
import '../../../domain/service/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthLoadingState()) {
    on<LogOutRequested>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await AuthService.logout();
        emit(UnauthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<AuthLoadUserEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        User user = await AuthService.loadUser();
        emit(AuthenticatedState(user: user));
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoadingState());
      try {
        //User user = await AuthService.login(email: event.user.email, password: event.user.password);
        User user = User(
            id: '',
            email: event.email,
            name: 'name',
            surname: 'surname',
            phone: 'phone',
            password: event.password,
            role: AccessLevel.user,
            accessToken: '',
            refreshToken: '');
        emit(AuthenticatedState(user: user));
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoadingState());
      try {
        User user = await AuthService.register(
            email: event.user.email,
            password: event.user.password,
            phone: event.user.phone,
            name: event.user.name,
            surname: event.user.surname);
        emit(AuthenticatedState(user: user));
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    add(AuthLoadUserEvent());
  }
}
