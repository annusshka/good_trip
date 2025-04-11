import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:good_trip/core/data/models/exception/auth_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnauthenticatedState()) {
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
  }

  Future<void> _logout(LogOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await authRepository.logout();
      AppMetrica.reportEvent('logout');
      emit(UnauthenticatedState());
    } catch (e) {
      emit(const AuthErrorState('Произошла ошибка'));
      AppMetrica.reportErrorWithGroup(
        'Authenticate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  Future<void> _loadUser(AuthLoadUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User user = await authRepository.loadUser();
      sendAnalytics(user);
      emit(AuthenticatedState(user: user));
    } catch (e) {
      emit(UnauthenticatedState());
      AppMetrica.reportErrorWithGroup(
        'Authenticate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
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
      sendAnalytics(user);
      AppMetrica.reportEvent('sign in');
      emit(AuthenticatedState(user: user));
    } on AuthError catch (e) {
      final statusCode = e.statusCode;
      if (statusCode != null) {
        switch (statusCode) {
          case 401:
            return emit(
              const AuthErrorState('Пользователя с такими данными не существует. Проверьте введенные данные'),
            );
          default:
            emit(const AuthErrorState('Возникла ошибка при авторизации'));
        }
      } else {
        emit(const AuthErrorState('Возникла ошибка при авторизации'));
      }
    } catch (e) {
      emit(const AuthErrorState('Возникла ошибка при авторизации'));
      AppMetrica.reportErrorWithGroup(
        'Authenticate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
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
      sendAnalytics(user);
      AppMetrica.reportEvent('sign up');
      emit(AuthenticatedState(user: user));
    } on AuthError catch (e) {
      final statusCode = e.statusCode;
      if (statusCode != null) {
        switch (statusCode) {
          case 422:
            return emit(AuthErrorState('Пользователь с e-mail ${event.user.email} уже зарегистрирован'));
          default:
            emit(const AuthErrorState('Возникла ошибка при регистрации'));
        }
      } else {
        emit(const AuthErrorState('Возникла ошибка при регистрации'));
      }
    } catch (e) {
      emit(const AuthErrorState('Возникла ошибка при регистрации'));
      AppMetrica.reportErrorWithGroup(
        'Authenticate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  void sendAnalytics(User user) {
    AppMetricaUserProfile userProfile = AppMetricaUserProfile([
      AppMetricaNameAttribute.withValue('${user.name} ${user.surname}'),
      AppMetricaStringAttribute.withValue('role', user.role.displayTitle),
    ]);

    AppMetrica.setUserProfileID(user.id.toString());
    AppMetrica.reportUserProfile(userProfile);
  }
}
