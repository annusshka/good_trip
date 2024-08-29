import 'package:get_it/get_it.dart';

import 'configure_dependencies.dart';
import 'register_modules.dart';

Future<GetIt> configureContainer() async {
  configureDependencies();
  final container = getIt;
  await initServices();

  return container;
}
