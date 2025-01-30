// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audio_service/audio_service.dart' as _i87;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:good_trip/core/app_router/app_router.dart' as _i416;
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler_impl.dart'
    as _i591;
import 'package:good_trip/core/data/repository/repository.dart' as _i73;
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart'
    as _i658;
import 'package:good_trip/core/data/service/service.dart' as _i505;
import 'package:good_trip/di/locator.dart' as _i906;
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart'
    as _i98;
import 'package:good_trip/features/account_list/data/service/account_list_service.dart'
    as _i227;
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart'
    as _i413;
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart'
    as _i14;
import 'package:good_trip/features/welcome/data/service/welcome_info_service.dart'
    as _i188;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final locator = _$Locator();
    gh.singleton<_i413.WeekdayCubit>(() => locator.weekdayCubit);
    gh.singleton<_i416.AppRouter>(() => locator.appRouter());
    gh.singleton<_i361.Dio>(() => locator.dio());
    gh.singleton<_i591.AudioPlayerHandlerImpl>(
        () => locator.audioPlayerHandler());
    await gh.singletonAsync<_i87.AudioHandler>(
      () => locator.audioHandler(gh<_i591.AudioPlayerHandlerImpl>()),
      preResolve: true,
    );
    gh.singleton<_i505.WeatherService>(
        () => locator.weatherService(gh<_i361.Dio>()));
    gh.singleton<_i505.ExcursionService>(
        () => locator.excursionService(gh<_i361.Dio>()));
    gh.singleton<_i505.TourService>(() => locator.tourService(gh<_i361.Dio>()));
    gh.singleton<_i505.ApiTourService>(
        () => locator.apiTourService(gh<_i361.Dio>()));
    gh.singleton<_i505.AuthService>(() => locator.authService(gh<_i361.Dio>()));
    gh.singleton<_i227.AccountListService>(
        () => locator.accountListService(gh<_i361.Dio>()));
    gh.singleton<_i188.WelcomeInfoService>(
        () => locator.welcomeInfoService(gh<_i361.Dio>()));
    gh.singleton<_i73.IAuthRepository>(
        () => locator.authRepository(gh<_i505.AuthService>()));
    gh.singleton<_i73.ITourRepository>(
        () => locator.tourRepository(gh<_i505.TourService>()));
    gh.singleton<_i73.IApiTourRepository>(
        () => locator.apiTourRepository(gh<_i505.ApiTourService>()));
    gh.singleton<_i98.IAccountListRepository>(
        () => locator.accountListRepository(gh<_i227.AccountListService>()));
    gh.singleton<_i73.IExcursionRepository>(
        () => locator.excursionRepository(gh<_i505.ExcursionService>()));
    gh.singleton<_i14.IWelcomeInfoRepository>(
        () => locator.welcomeInfoRepository(gh<_i188.WelcomeInfoService>()));
    gh.singleton<_i658.IWeatherRepository>(
        () => locator.weatherRepository(gh<_i505.WeatherService>()));
    return this;
  }
}

class _$Locator extends _i906.Locator {}
