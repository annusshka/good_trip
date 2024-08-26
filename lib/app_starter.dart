import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:good_trip/di/di_builder.dart';
import 'package:good_trip/di/dio_configurator.dart';

class AppStarter {
  String get devicePlatform => Platform.isIOS ? 'iOS' : 'android';

  late final Dio dio;

  late GetIt container;

  Future<void> startApp() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    dio = configDio();

    container = await configureContainer();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icon color
      systemNavigationBarIconBrightness:
      Brightness.dark, // color of navigation controls
    ));
  }
}

final starter = AppStarter();
