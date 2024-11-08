import 'package:dio/dio.dart';
import 'package:good_trip/core/data/models/exception/tour_error.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/service/service.dart';

class MockTourRepository implements ITourRepository {
  MockTourRepository({required this.service});

  final TourService service;

  static List<Tour> iTourList = [
    Tour(
      id: '1',
      name: 'Аудио-тур №1',
      imageUrl:
          'goodTrip_photo_%D0%B2%D0%B8%D0%B7%D0%B8%D1%82%D0%BD%D0%B0%D1%8F.jpg?updatedAt=1717931827900',
      address: const Address(
        coordinates: Point(lon: 51.4, lat: 39.12),
        country: 'Россия',
        city: 'Воронеж',
        street: 'Московский пр-кт',
        house: '1',
      ),
      kinds: [
        TourType.archaeology.displayText,
        TourType.amusements.displayText,
        TourType.cultural.displayText,
      ],
      weekdays: [Weekday.monday, Weekday.friday],
      description:
          'Что вас ожидает\nСамое-самое в Воронеже\nВы увидите главные '
          'достопримечательности столицы Черноземья: Адмиралтейскую площадь, проспект '
          'Революции, Благовещенский собор и комплекс Алексеево-Акатова монастыря с '
          'некрополем и старинной колокольней. Рассмотрите корабль Гото Предестинация и '
          'раскроете, почему Петр I выбрал для строительства флота именно наш город. А '
          'также отыщете лечебный стул в Платоновском сквере и оцените современный '
          'символ Воронежа — памятник котенку с улицы Лизюкова.\nДворец Ольденбургских\n'
          'Мы погуляем по территории бывшей резиденции Ольденбургских. Я покажу '
          'неоготический дворец в староанглийском стиле, ворота с башней и старинный '
          'флигель. Расскажу о семье принцев Ольденбургских и их роли в общественной '
          'жизни России, о любви багрянородной княжны Романовой и прославленного '
          'инженера Мосина и об образцовом хозяйстве, созданном в Рамони правнучкой '
          'французской императрицы Жозефины.',
      isLiked: false,
      excursionList: [],
    ),
    Tour(
      id: '2',
      name: 'Аудио-тур №2',
      imageUrl: 'goodTrip_photo_2.jpg?updatedAt=1717931856240',
      address: const Address(
        coordinates: Point(lon: 51.4, lat: 39.12),
        country: 'Россия',
        city: 'Воронеж',
        street: 'Московский пр-кт',
      ),
      kinds: [
        TourType.archaeology.displayText,
        TourType.amusements.displayText,
        TourType.cultural.displayText,
      ],
      weekdays: [Weekday.monday, Weekday.friday],
      description:
          'Что вас ожидает\nСамое-самое в Воронеже\nВы увидите главные '
          'достопримечательности столицы Черноземья: Адмиралтейскую площадь, проспект '
          'Революции, Благовещенский собор и комплекс Алексеево-Акатова монастыря с '
          'некрополем и старинной колокольней. Рассмотрите корабль Гото Предестинация и '
          'раскроете, почему Петр I выбрал для строительства флота именно наш город. А '
          'также отыщете лечебный стул в Платоновском сквере и оцените современный '
          'символ Воронежа — памятник котенку с улицы Лизюкова.\nДворец Ольденбургских\n'
          'Мы погуляем по территории бывшей резиденции Ольденбургских. Я покажу '
          'неоготический дворец в староанглийском стиле, ворота с башней и старинный '
          'флигель. Расскажу о семье принцев Ольденбургских и их роли в общественной '
          'жизни России, о любви багрянородной княжны Романовой и прославленного '
          'инженера Мосина и об образцовом хозяйстве, созданном в Рамони правнучкой '
          'французской императрицы Жозефины.',
      isLiked: true,
      excursionList: [],
    ),
    Tour(
      id: '3',
      name: 'Аудио-тур №3',
      imageUrl: 'goodTrip_photo_5.jpg?updatedAt=1717931868349',
      address: const Address(
        coordinates: Point(lon: 51.4, lat: 39.12),
        country: 'Россия',
        city: 'Воронеж',
        street: 'Московский пр-кт',
      ),
      kinds: [
        TourType.archaeology.displayText,
        TourType.amusements.displayText,
        TourType.cultural.displayText,
      ],
      weekdays: [Weekday.monday, Weekday.friday],
      description:
          'Что вас ожидает\nСамое-самое в Воронеже\nВы увидите главные '
          'достопримечательности столицы Черноземья: Адмиралтейскую площадь, проспект '
          'Революции, Благовещенский собор и комплекс Алексеево-Акатова монастыря с '
          'некрополем и старинной колокольней. Рассмотрите корабль Гото Предестинация и '
          'раскроете, почему Петр I выбрал для строительства флота именно наш город. А '
          'также отыщете лечебный стул в Платоновском сквере и оцените современный '
          'символ Воронежа — памятник котенку с улицы Лизюкова.\nДворец Ольденбургских\n'
          'Мы погуляем по территории бывшей резиденции Ольденбургских. Я покажу '
          'неоготический дворец в староанглийском стиле, ворота с башней и старинный '
          'флигель. Расскажу о семье принцев Ольденбургских и их роли в общественной '
          'жизни России, о любви багрянородной княжны Романовой и прославленного '
          'инженера Мосина и об образцовом хозяйстве, созданном в Рамони правнучкой '
          'французской императрицы Жозефины.',
      isLiked: false,
      excursionList: [],
    ),
    Tour(
      id: '4',
      name: 'Аудио-тур №4',
      imageUrl: 'goodTrip_photo_6.jpg?updatedAt=1717931879992',
      address: const Address(
        coordinates: Point(lon: 51.4, lat: 39.12),
        country: 'Россия',
        city: 'Воронеж',
        street: 'Московский пр-кт',
      ),
      kinds: [
        TourType.archaeology.displayText,
        TourType.amusements.displayText,
        TourType.cultural.displayText,
      ],
      weekdays: [Weekday.monday, Weekday.friday],
      description:
          'Что вас ожидает\nСамое-самое в Воронеже\nВы увидите главные '
          'достопримечательности столицы Черноземья: Адмиралтейскую площадь, проспект '
          'Революции, Благовещенский собор и комплекс Алексеево-Акатова монастыря с '
          'некрополем и старинной колокольней. Рассмотрите корабль Гото Предестинация и '
          'раскроете, почему Петр I выбрал для строительства флота именно наш город. А '
          'также отыщете лечебный стул в Платоновском сквере и оцените современный '
          'символ Воронежа — памятник котенку с улицы Лизюкова.\nДворец Ольденбургских\n'
          'Мы погуляем по территории бывшей резиденции Ольденбургских. Я покажу '
          'неоготический дворец в староанглийском стиле, ворота с башней и старинный '
          'флигель. Расскажу о семье принцев Ольденбургских и их роли в общественной '
          'жизни России, о любви багрянородной княжны Романовой и прославленного '
          'инженера Мосина и об образцовом хозяйстве, созданном в Рамони правнучкой '
          'французской императрицы Жозефины.',
      isLiked: true,
      excursionList: [],
    ),
    Tour(
      id: '5',
      name: 'Аудио-тур №5',
      imageUrl: 'goodTrip_photo_3.jpg?updatedAt=1717931892355',
      address: const Address(
        coordinates: Point(lon: 51.4, lat: 39.12),
        country: 'Россия',
        city: 'Воронеж',
        street: 'Московский пр-кт',
      ),
      kinds: [
        TourType.archaeology.displayText,
        TourType.amusements.displayText,
        TourType.cultural.displayText,
      ],
      weekdays: [Weekday.monday, Weekday.friday],
      description:
          'Что вас ожидает\nСамое-самое в Воронеже\nВы увидите главные '
          'достопримечательности столицы Черноземья: Адмиралтейскую площадь, проспект '
          'Революции, Благовещенский собор и комплекс Алексеево-Акатова монастыря с '
          'некрополем и старинной колокольней. Рассмотрите корабль Гото Предестинация и '
          'раскроете, почему Петр I выбрал для строительства флота именно наш город. А '
          'также отыщете лечебный стул в Платоновском сквере и оцените современный '
          'символ Воронежа — памятник котенку с улицы Лизюкова.\nДворец Ольденбургских\n'
          'Мы погуляем по территории бывшей резиденции Ольденбургских. Я покажу '
          'неоготический дворец в староанглийском стиле, ворота с башней и старинный '
          'флигель. Расскажу о семье принцев Ольденбургских и их роли в общественной '
          'жизни России, о любви багрянородной княжны Романовой и прославленного '
          'инженера Мосина и об образцовом хозяйстве, созданном в Рамони правнучкой '
          'французской императрицы Жозефины.',
      isLiked: true,
      excursionList: [],
    ),
    Tour(
      id: '6',
      name: 'Аудио-тур №6',
      imageUrl: 'goodTrip_photo_3.jpg?updatedAt=1717931892355',
      address: const Address(
        coordinates: Point(lon: 51.4, lat: 39.12),
        country: 'Россия',
        city: 'Воронеж',
        street: 'Московский пр-кт',
      ),
      kinds: [
        TourType.archaeology.displayText,
        TourType.amusements.displayText,
        TourType.cultural.displayText,
      ],
      weekdays: [Weekday.monday, Weekday.friday],
      description:
          'Что вас ожидает\nСамое-самое в Воронеже\nВы увидите главные '
          'достопримечательности столицы Черноземья: Адмиралтейскую площадь, проспект '
          'Революции, Благовещенский собор и комплекс Алексеево-Акатова монастыря с '
          'некрополем и старинной колокольней. Рассмотрите корабль Гото Предестинация и '
          'раскроете, почему Петр I выбрал для строительства флота именно наш город. А '
          'также отыщете лечебный стул в Платоновском сквере и оцените современный '
          'символ Воронежа — памятник котенку с улицы Лизюкова.\nДворец Ольденбургских\n'
          'Мы погуляем по территории бывшей резиденции Ольденбургских. Я покажу '
          'неоготический дворец в староанглийском стиле, ворота с башней и старинный '
          'флигель. Расскажу о семье принцев Ольденбургских и их роли в общественной '
          'жизни России, о любви багрянородной княжны Романовой и прославленного '
          'инженера Мосина и об образцовом хозяйстве, созданном в Рамони правнучкой '
          'французской императрицы Жозефины.',
      isLiked: true,
      excursionList: [],
    ),
    Tour(
      id: '7',
      name: 'Аудио-тур №7',
      imageUrl: 'goodTrip_photo_3.jpg?updatedAt=1717931892355',
      address: const Address(
        coordinates: Point(lon: 55.45, lat: 37.37),
        country: 'Россия',
        city: 'Москва',
      ),
      kinds: [
        TourType.archaeology.displayText,
        TourType.amusements.displayText,
        TourType.cultural.displayText,
      ],
      weekdays: [Weekday.monday, Weekday.friday],
      description:
          'Что вас ожидает\nСамое-самое в Воронеже\nВы увидите главные '
          'достопримечательности столицы Черноземья: Адмиралтейскую площадь, проспект '
          'Революции, Благовещенский собор и комплекс Алексеево-Акатова монастыря с '
          'некрополем и старинной колокольней. Рассмотрите корабль Гото Предестинация и '
          'раскроете, почему Петр I выбрал для строительства флота именно наш город. А '
          'также отыщете лечебный стул в Платоновском сквере и оцените современный '
          'символ Воронежа — памятник котенку с улицы Лизюкова.\nДворец Ольденбургских\n'
          'Мы погуляем по территории бывшей резиденции Ольденбургских. Я покажу '
          'неоготический дворец в староанглийском стиле, ворота с башней и старинный '
          'флигель. Расскажу о семье принцев Ольденбургских и их роли в общественной '
          'жизни России, о любви багрянородной княжны Романовой и прославленного '
          'инженера Мосина и об образцовом хозяйстве, созданном в Рамони правнучкой '
          'французской императрицы Жозефины.',
      isLiked: true,
      excursionList: [],
    ),
    Tour(
      id: '8',
      name: 'Аудио-тур №8',
      imageUrl: 'goodTrip_photo_3.jpg?updatedAt=1717931892355',
      address: const Address(
        coordinates: Point(lon: 51.4, lat: 39.12),
        country: 'Россия',
        city: 'Воронеж',
        street: 'Московский пр-кт',
      ),
      kinds: [
        TourType.archaeology.displayText,
        TourType.amusements.displayText,
        TourType.cultural.displayText,
      ],
      weekdays: [Weekday.monday, Weekday.friday],
      description:
          'Что вас ожидает\nСамое-самое в Воронеже\nВы увидите главные '
          'достопримечательности столицы Черноземья: Адмиралтейскую площадь, проспект '
          'Революции, Благовещенский собор и комплекс Алексеево-Акатова монастыря с '
          'некрополем и старинной колокольней. Рассмотрите корабль Гото Предестинация и '
          'раскроете, почему Петр I выбрал для строительства флота именно наш город. А '
          'также отыщете лечебный стул в Платоновском сквере и оцените современный '
          'символ Воронежа — памятник котенку с улицы Лизюкова.\nДворец Ольденбургских\n'
          'Мы погуляем по территории бывшей резиденции Ольденбургских. Я покажу '
          'неоготический дворец в староанглийском стиле, ворота с башней и старинный '
          'флигель. Расскажу о семье принцев Ольденбургских и их роли в общественной '
          'жизни России, о любви багрянородной княжны Романовой и прославленного '
          'инженера Мосина и об образцовом хозяйстве, созданном в Рамони правнучкой '
          'французской императрицы Жозефины.',
      isLiked: true,
      excursionList: [],
    ),
    Tour(
      id: '9',
      name: 'Аудио-тур №9',
      imageUrl: 'goodTrip_photo_3.jpg?updatedAt=1717931892355',
      address: const Address(
        coordinates: Point(lon: 51.4, lat: 39.12),
        country: 'Россия',
        city: 'Воронеж',
        street: 'Московский пр-кт',
      ),
      kinds: [
        TourType.archaeology.displayText,
        TourType.amusements.displayText,
        TourType.cultural.displayText,
      ],
      weekdays: [Weekday.monday, Weekday.friday],
      description:
          'Что вас ожидает\nСамое-самое в Воронеже\nВы увидите главные '
          'достопримечательности столицы Черноземья: Адмиралтейскую площадь, проспект '
          'Революции, Благовещенский собор и комплекс Алексеево-Акатова монастыря с '
          'некрополем и старинной колокольней. Рассмотрите корабль Гото Предестинация и '
          'раскроете, почему Петр I выбрал для строительства флота именно наш город. А '
          'также отыщете лечебный стул в Платоновском сквере и оцените современный '
          'символ Воронежа — памятник котенку с улицы Лизюкова.\nДворец Ольденбургских\n'
          'Мы погуляем по территории бывшей резиденции Ольденбургских. Я покажу '
          'неоготический дворец в староанглийском стиле, ворота с башней и старинный '
          'флигель. Расскажу о семье принцев Ольденбургских и их роли в общественной '
          'жизни России, о любви багрянородной княжны Романовой и прославленного '
          'инженера Мосина и об образцовом хозяйстве, созданном в Рамони правнучкой '
          'французской императрицы Жозефины.',
      isLiked: true,
      excursionList: [],
    ),
  ];

  @override
  Future<List<Tour>> getTours({
    required int userId,
    required String city,
    required double lon,
    required double lat,
    int offset = 0,
  }) async {
    try {
      return iTourList;
    } on DioException catch (error) {
      throw TourError(
        name: 'GetAudioTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Tour>> getCreatedTours({int offset = 0}) async {
    try {
      return iTourList;
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Tour>> getCreatedToursByAdmin(
      {int offset = 0}) async {
    try {
      return iTourList;
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Tour>> getCreatedToursByUserId({
    required int userId,
    int offset = 0,
  }) async {
    try {
      return iTourList;
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> likeTour({
    required int userId,
    required String id,
  }) async {
    try {
      final _id = int.tryParse(id);
      if (_id != null) {
        iTourList[_id - 1].isLiked = !iTourList[_id - 1].isLiked;
      }
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Tour>> getFavoriteTours(
      {required int userId, int offset = 0}) async {
    try {
      List<Tour> list = [];
      for (final Tour tour in iTourList) {
        if (tour.isLiked) list.add(tour);
      }
      return list;
    } on DioException catch (error) {
      throw TourError(
        name: 'GetFavoriteTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteTour({
    required String id,
  }) async {
    try {
      final _id = int.tryParse(id);
      if (_id != null) {
        for (final Tour audioTour in iTourList) {
          if (audioTour.id == id) iTourList.remove(audioTour);
        }
      }
    } on DioException catch (error) {
      throw TourError(
        name: 'GetCreatedTourList',
        message: error.response?.data['message'],
        errorText: error.response?.data['errorText'] ?? '',
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
