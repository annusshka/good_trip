import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/app_starter.dart';
import 'package:good_trip/core/data/interceptor/jwt_interceptor.dart';
import 'package:good_trip/core/data/repository/auth/impl/mock_auth_repository.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/repository/tour/impl/mock_tour_repository.dart';
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart';
import 'package:good_trip/core/data/repository/weather/impl/weather_repository.dart';
import 'package:good_trip/core/data/service/service.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart';
import 'package:good_trip/features/account_list/data/repository/impl/account_list_repository.dart';
import 'package:good_trip/features/account_list/data/repository/impl/mock_account_list_repository.dart';
import 'package:good_trip/features/account_list/data/service/account_list_service.dart';
import 'package:injectable/injectable.dart';

Future<void> initServices() async {
  const FlutterSecureStorage storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // final jwtInterceptor = JwtInterceptor(
  //   dio: starter.dio,
  //   storage: storage,
  // );
  //
  // starter.dio.interceptors.add(jwtInterceptor);
  // await jwtInterceptor.initTokens();

  // final city = await geo.loadCity();
  //
  // if (city != null) {
  //   geo.setCity(city);
  // } else {
  //   final updatedCity = await geo.updateGeolocation();
  //   geo.setCity(updatedCity);
  // }
}

@module
abstract class RegisterModules {
  // @factoryMethod
  // WeatherService get weatherService => WeatherService(dio: starter.dio);

  // @factoryMethod
  // TourService get tourService => TourService(starter.dio);

  // @factoryMethod
  // AuthService get authService => AuthService(starter.dio);

  // late final ITourRepository tourRepository =
  //     TourRepository(service: tourService);
  //
  // late final IAuthRepository authRepository =
  //     AuthRepository(service: authService);

  static final WeatherRepository _weatherRepository =
      WeatherRepository(service: WeatherService(dio: starter.dio));

  static final MockTourRepository _tourRepository = MockTourRepository(
    service: TourService(starter.dio),
  );

  static final ApiTourRepository _apiTourRepository = ApiTourRepository(
    service: ApiTourService(starter.dio),
  );

  static final MockAuthRepository _authRepository = MockAuthRepository(
    service: AuthService(starter.dio),
  );

  static final MockAccountListRepository _accountListRepository = MockAccountListRepository(
    service: AccountListService(starter.dio),
  );

  @Singleton(as: IWeatherRepository)
  WeatherRepository get weatherRepository => _weatherRepository;

  @Singleton(as: ITourRepository)
  MockTourRepository get tourRepository => _tourRepository;

  @Singleton(as: IApiTourRepository)
  ApiTourRepository get apiTourRepository => _apiTourRepository;

  @Singleton(as: IAuthRepository)
  MockAuthRepository get authRepository => _authRepository;

  @Singleton(as: IAccountListRepository)
  MockAccountListRepository get accountListRepository => _accountListRepository;
  //
  // static final TourBloc _tourBloc = TourBloc(tourRepository: _tourRepository);
  //
  // @singleton
  // TourBloc get tourBloc => _tourBloc;
}
