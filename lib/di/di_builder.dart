import 'package:get_it/get_it.dart';

import 'configure_dependencies.dart';
import 'locator.dart';

Future<GetIt> configureContainer() async {
  setUpLocator();
  final container = getIt;
  await initServices();

  return container;
}
