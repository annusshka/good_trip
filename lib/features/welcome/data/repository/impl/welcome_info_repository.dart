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
    final isFirstRun = await checkFirstRun();
    if (isFirstRun) {
      return await service.getWelcomeInfoList();
    }

    return null;
  }

  @override
  Future<bool> checkFirstRun() async {
    final firstRun = await _storage.read(
      key: 'first_run',
    );

    return bool.tryParse(firstRun ?? 'true') ?? true;
  }

  @override
  Future<void> setFirstRun() async {
    await _storage.write(
      key: 'first_run',
      value: 'false',
    );
  }
}
