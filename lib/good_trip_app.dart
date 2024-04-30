import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/strings.dart';
import 'package:good_trip/core/theme/theme.dart';
import 'package:good_trip/features/splashscreen/presentation/splash_screen.dart';

class GoodTripApp extends StatefulWidget {
  const GoodTripApp({super.key});

  @override
  State<GoodTripApp> createState() => _GoodTripAppState();
}

class _GoodTripAppState extends State<GoodTripApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: goodTrip,
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}