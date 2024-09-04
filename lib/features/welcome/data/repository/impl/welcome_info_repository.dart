import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/features/welcome/data/models/welcome_info/welcome_info.dart';
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart';
import 'package:good_trip/features/welcome/data/service/welcome_info_service.dart';

class WelcomeInfoRepository extends IWelcomeInfoRepository {
  final WelcomeInfoService service;
  final FlutterSecureStorage _storage;

  WelcomeInfoRepository({
    required this.service,
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  @override
  Future<List<WelcomeInfo>?> getWelcomeInfo() async {
    if (await _storage.containsKey(key: 'first_run')) {
      final firstRun = await _storage.read(key: 'first_run') as bool;
      if (firstRun) {
        return await service.getWelcomeInfoList();
      }
    }

    return null;
  }
}
