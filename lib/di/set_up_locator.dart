import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'set_up_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void setUpLocator() => getIt.init();
