import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class StartUpDomains extends StatelessWidget {
  const StartUpDomains({
    required this.child,
    super.key,
    required this.container,
  });

  final GetIt container;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => container,
      child: child,
    );
  }
}
