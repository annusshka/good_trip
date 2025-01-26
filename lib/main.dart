import 'package:flutter/material.dart';
import 'package:good_trip/app_starter.dart';
import 'package:good_trip/core/domain/startup_domain.dart';
import 'package:good_trip/good_trip_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await starter.startApp();

  runApp(
    StartUpDomains(
      container: starter.container,
      child: const GoodTripApp(),
    ),
  );
}
