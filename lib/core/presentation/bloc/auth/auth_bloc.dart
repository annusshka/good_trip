import 'package:bloc/bloc.dart';
import 'package:good_trip/core/data/models/auth/auth_request.dart';
import 'package:good_trip/core/data/models/auth/login_request.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthLoadingState()) {
    on<LogOutRequested>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authRepository.logout();
        emit(UnauthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<AuthLoadUserEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        User user = await authRepository.loadUser();
        emit(AuthenticatedState(user: user));
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoadingState());
      try {
        User user = await authRepository.login(
          loginRequest: LoginRequest(
            email: event.email,
            password: event.password,
          ),
        );
        // User user = User(
        //     id: 0,
        //     email: event.email,
        //     name: 'name',
        //     surname: 'surname',
        //     phone: 'phone',
        //     password: event.password,
        //     role: AccessLevel.USER,
        //     accessToken: '',
        //     refreshToken: '');
        // if (event.email == 'admin@gmail.com' && event.password == 'admin__') {
        //   user = User(
        //       id: 0,
        //       email: event.email,
        //       name: 'adminName',
        //       surname: 'adminSurname',
        //       phone: 'adminPhone',
        //       password: event.password,
        //       role: AccessLevel.ADMIN,
        //       accessToken: '',
        //       refreshToken: '');
        // }
        emit(AuthenticatedState(user: user));
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    on<SignUpRequested>((event, emit) async {
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
    });

    add(AuthLoadUserEvent());
  }
}
