import 'package:get_it/get_it.dart';

import 'locator.dart';
import 'set_up_locator.dart';

Future<GetIt> configureContainer() async {
  setUpLocator();
  final container = getIt;
  await initServices();

  return container;
}
