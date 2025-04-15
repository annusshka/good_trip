import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler_impl2.dart';
import 'package:good_trip/core/data/api/api_key.dart';
import 'package:good_trip/core/data/repository/auth/impl/mock_auth_repository.dart';
import 'package:good_trip/core/data/repository/excursion/impl/mock_excursion_repository.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/repository/tour/impl/mock_tour_repository.dart';
import 'package:good_trip/core/data/repository/tour/impl/tour_repository.dart';
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart';
import 'package:good_trip/core/data/repository/weather/impl/weather_repository.dart';
import 'package:good_trip/core/data/service/service.dart';
import 'package:good_trip/features/account_list/data/repository/i_account_list_repository.dart';
import 'package:good_trip/features/account_list/data/repository/impl/account_list_repository.dart';
import 'package:good_trip/features/account_list/data/repository/impl/mock_account_list_repository.dart';
import 'package:good_trip/features/account_list/data/service/account_list_service.dart';
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart';
import 'package:good_trip/features/welcome/data/repository/impl/mock_welcome_info_repository.dart';
import 'package:good_trip/features/welcome/data/service/welcome_info_service.dart';
import 'package:good_trip/firebase_options.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'config_dio.dart';

Future<void> initServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AppMetrica.activate(const AppMetricaConfig(appMetricaKey));

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(oneSignalKey);

  OneSignal.Notifications.requestPermission(true);
}

@module
abstract class Locator {
  @singleton
  AppRouter appRouter() {
    return AppRouter();
  }

  @singleton
  Dio dio() {
    return configDio();
  }

  @singleton
  WeatherService weatherService() {
    final weatherDio = Dio();
    return WeatherService(dio: weatherDio);
  }

  @singleton
  IWeatherRepository weatherRepository(WeatherService service) {
    return WeatherRepository(service: service);
  }

  @singleton
  ExcursionService excursionService(Dio dio) {
    return ExcursionService(dio);
  }

  @singleton
  IExcursionRepository excursionRepository(ExcursionService service) {
    return ExcursionRepository(service: service);
  }

  @singleton
  TourService tourService(Dio dio) {
    return TourService(dio);
  }

  @singleton
  ITourRepository tourRepository(TourService service) {
    return TourRepository(service: service);
  }

  @singleton
  ApiTourService apiTourService() {
    final apiTourDio = Dio();
    return ApiTourService(apiTourDio);
  }

  @singleton
  IApiTourRepository apiTourRepository(ApiTourService service) {
    return ApiTourRepository(service: service);
  }

  @singleton
  AuthService authService(Dio dio) {
    return AuthService(dio);
  }

  @singleton
  IAuthRepository authRepository(AuthService service) {
    return AuthRepository(service: service);
  }

  @singleton
  AccountListService accountListService(Dio dio) {
    return AccountListService(dio);
  }

  @singleton
  IAccountListRepository accountListRepository(AccountListService service) {
    return AccountListRepository(service: service);
  }

  @singleton
  WelcomeInfoService welcomeInfoService(Dio dio) {
    return WelcomeInfoService(dio);
  }

  @singleton
  IWelcomeInfoRepository welcomeInfoRepository(WelcomeInfoService service) {
    return MockWelcomeInfoRepository(service: service);
  }

  @singleton
  AudioPlayer audioPlayer() {
    return AudioPlayer();
  }

  @singleton
  AudioPlayerHandler audioPlayerHandler(AudioPlayer audioPlayer) {
    final handler = AudioPlayerHandler(player: audioPlayer);
    handler.init();
    return handler;
  }

  @singleton
  @preResolve
  Future<AudioHandler> audioHandler(AudioPlayerHandler audioPlayerHandler) async {
    return await AudioService.init(
      builder: () => audioPlayerHandler,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.good_trip.myapp.channel.audio',
        androidNotificationChannelName: 'Music playback',
        androidNotificationOngoing: true,
      ),
    );
  }
}
