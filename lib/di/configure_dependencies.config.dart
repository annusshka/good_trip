// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:good_trip/core/data/repository/repository.dart' as _i73;
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart'
    as _i658;
import 'package:good_trip/di/register_modules.dart' as _i593;
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart'
    as _i98;
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
    gh.singleton<_i73.IAuthRepository>(() => registerModules.authRepository);
    gh.singleton<_i73.ITourRepository>(() => registerModules.tourRepository);
    gh.singleton<_i658.IWeatherRepository>(
        () => registerModules.weatherRepository);
    gh.singleton<_i98.IAccountListRepository>(
        () => registerModules.accountListRepository);
    gh.singleton<_i73.IApiTourRepository>(
        () => registerModules.apiTourRepository);
    return this;
  }
}

class _$RegisterModules extends _i593.RegisterModules {}
