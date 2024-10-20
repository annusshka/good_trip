// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:good_trip/core/app_router/app_router.dart' as _i416;
import 'package:good_trip/core/data/repository/repository.dart' as _i73;
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart'
    as _i658;
import 'package:good_trip/di/locator.dart' as _i593;
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart'
    as _i98;
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart'
    as _i1048;
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart'
    as _i14;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModules = _$RegisterModules();
    gh.singleton<_i416.AppRouter>(() => registerModules.appRouter);
    gh.singleton<_i1048.WeekdayCubit>(() => registerModules.weekdayCubit);
    gh.singleton<_i73.IAuthRepository>(() => registerModules.authRepository);
    gh.singleton<_i73.ITourRepository>(() => registerModules.tourRepository);
    gh.singleton<_i658.IWeatherRepository>(
        () => registerModules.weatherRepository);
    gh.singleton<_i98.IAccountListRepository>(
        () => registerModules.accountListRepository);
    gh.singleton<_i73.IApiTourRepository>(
        () => registerModules.apiTourRepository);
    gh.singleton<_i14.IWelcomeInfoRepository>(
        () => registerModules.welcomeInfoRepository);
    return this;
  }
}

class _$RegisterModules extends _i593.Locator {}
