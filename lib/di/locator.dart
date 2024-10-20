import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/app_starter.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/repository/auth/impl/mock_auth_repository.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/repository/tour/impl/mock_tour_repository.dart';
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart';
import 'package:good_trip/core/data/repository/weather/impl/weather_repository.dart';
import 'package:good_trip/core/data/service/service.dart';
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart';
import 'package:good_trip/features/account_list/data/repository/impl/mock_account_list_repository.dart';
import 'package:good_trip/features/account_list/data/service/account_list_service.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart';
import 'package:good_trip/features/welcome/data/repository/impl/mock_welcome_info_repository.dart';
import 'package:good_trip/features/welcome/data/service/welcome_info_service.dart';
import 'package:good_trip/firebase_options.dart';
import 'package:injectable/injectable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize('d97fa2b4-44b4-4c5e-8dd7-a0531cfee238');

  OneSignal.Notifications.requestPermission(true);
}

@module
abstract class Locator {

  static final AppRouter _appRouter = AppRouter();

  @singleton
  AppRouter get appRouter => _appRouter;

  static final WeatherRepository _weatherRepository = WeatherRepository(
    service: WeatherService(dio: starter.dio),
  );

  static final MockTourRepository _tourRepository = MockTourRepository(
    service: TourService(starter.dio),
  );

  static final ApiTourRepository _apiTourRepository = ApiTourRepository(
    service: ApiTourService(starter.dio),
  );

  static final MockAuthRepository _authRepository = MockAuthRepository(
    service: AuthService(starter.dio),
  );

  static final MockAccountListRepository _accountListRepository =
      MockAccountListRepository(
    service: AccountListService(starter.dio),
  );

  static final MockWelcomeInfoRepository _welcomeInfoRepository =
      MockWelcomeInfoRepository(
    service: WelcomeInfoService(starter.dio),
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

  @Singleton(as: IWelcomeInfoRepository)
  MockWelcomeInfoRepository get welcomeInfoRepository => _welcomeInfoRepository;

  static final WeekdayCubit _weekdayCubit = WeekdayCubit();

  @singleton
  WeekdayCubit get weekdayCubit => _weekdayCubit;
}
