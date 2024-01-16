import 'package:flutter/material.dart';
import 'package:good_trip/routes/routes.dart';
import 'package:good_trip/theme/theme.dart';

class GoodTripApp extends StatelessWidget {
  const GoodTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good Trip',
      theme: mainTheme,
      routes: route,
    );
  }
}