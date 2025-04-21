import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:good_trip/features/welcome/data/models/welcome_info/welcome_info.dart';
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart';
import 'package:good_trip/features/welcome/data/service/welcome_info_service.dart';

class MockWelcomeInfoRepository extends IWelcomeInfoRepository {
  final WelcomeInfoService service;
  final FlutterSecureStorage _storage;

  MockWelcomeInfoRepository({
    required this.service,
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  }) : _storage = storage;

  @override
  Future<List<WelcomeInfo>?> getWelcomeInfo() async {
    final isFirstRun = await checkFirstRun();
    if (isFirstRun) {
      return await [
        const WelcomeInfo(
          text: 'Добро пожаловать в UnknownPlace',
          subtext: 'Откройте для себя очарование этого мира. '
              'Познакомьтесь с культурой, ландшафтами и наследием. '
              'Ваш идеальный путеводитель.',
          image:
          'https://ik.imagekit.io/vqwafkkyo/goodTrip/photo/welcome11.png?updatedAt=1725398118547',
        ),
        const WelcomeInfo(
          text: 'Находите интересные места',
          subtext: 'Мы предоставляем доступ ко множеству различных интересных '
              'мест и аудиоэкскурсий.',
          image:
          'https://ik.imagekit.io/vqwafkkyo/goodTrip/photo/welcome2.jpg?updatedAt=1725395760173',
        ),
        const WelcomeInfo(
          text: 'Делитесь вашими любимыми местами',
          subtext: 'Создавайте собственные туры по вашим любимым местам города.',
          image:
          'https://ik.imagekit.io/vqwafkkyo/goodTrip/photo/welcome12.png?updatedAt=1725398118396',
        ),
      ];
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
