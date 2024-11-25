import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:good_trip/di/di_builder.dart';

class AppStarter {
  String get devicePlatform => Platform.isIOS ? 'iOS' : 'android';

  late GetIt container;

  Future<void> startApp() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    container = await configureContainer();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
}

final starter = AppStarter();
