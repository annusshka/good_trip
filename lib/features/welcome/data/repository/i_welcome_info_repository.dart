import 'package:good_trip/features/welcome/data/models/welcome_info/welcome_info.dart';

abstract class IWelcomeInfoRepository {
  Future<List<WelcomeInfo>?> getWelcomeInfo();

  Future<bool> checkFirstRun();

  Future<void> setFirstRun();
}
