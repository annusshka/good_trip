import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:good_trip/core/domain/service/service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:postgres/postgres.dart';

import '../../data/api/api_key.dart';
import '../models/models.dart';

//lon: 38.364285, lat: 59.855685
List<AudioTour> tourList = [
  AudioTour(
      id: '',
      name: 'Что-то в Воронеже',
      image:
          'https://sportishka.com/uploads/posts/2022-04/1650685335_5-sportishka-com-p-blagoveshchenskii-sobor-voronezh-krasivo-f-5.jpg',
      weekdays: [Weekday.tuesday, Weekday.wednesday, Weekday.friday],
      coordinates: const Point(38.5, 39.5),
      description: 'Что-то красивое в Воронеже',
      kinds: [TourType.religion.displayText, TourType.architecture.displayText],
      address: const Address(
          country: 'Россия',
          city: 'Воронеж',
          street: 'проспект Революции',
          house: '14В'),
      isLiked: false,
      audioFile: '')
];

class TourService {
  final dio = Dio();

  static Map<String, String> kindsMap = {
    'accomodations': TourType.accomodations.displayText,
    'adult': TourType.adult.displayText,
    'amusements': TourType.amusements.displayText,
    'interesting_places': TourType.interesting_places.displayText,
    'cultural': TourType.cultural.displayText,
    'architecture': TourType.architecture.displayText,
    'museums': TourType.museums.displayText,
    'theatres_and_entertainments':
        TourType.theatres_and_entertainments.displayText,
    'archaeology': TourType.archaeology.displayText,
    'burial_places': TourType.burial_places.displayText,
    'monuments_and_memorials': TourType.monuments_and_memorials.displayText,
    'natural': TourType.natural.displayText,
    'beaches': TourType.beaches.displayText,
    'geological_formations': TourType.geological_formations.displayText,
    'islands': TourType.islands.displayText,
    'natural_springs': TourType.natural_springs.displayText,
    'nature_reserves': TourType.nature_reserves.displayText,
    'water': TourType.water.displayText,
    'religion': TourType.religion.displayText,
    'sport': TourType.sport.displayText,
    'climbing': TourType.climbing.displayText,
    'diving': TourType.diving.displayText,
    'winter_sports': TourType.winter_sports.displayText,
    'banks': TourType.banks.displayText,
    'foods': TourType.foods.displayText,
    'shops': TourType.shops.displayText,
    'transport': TourType.transport.displayText
  };

  /*
  @override
  Future<List<Tour>> getTourList() async{
    final response = await Dio().get(
        'http://api.opentripmap.com/0.1/ru/places/bbox?'
            'lon_min=38.364285&lat_min=59.855685&lon_max=38.372809&'
            'lat_max=59.859052&format=geojson&limit=10&apikey=$tripKey');
    final data = response.data as Map<String, dynamic>;
    final dataFeatures = data['features'];
    List<Tour> dataList = [];
    for (Map<String, dynamic> actData in dataFeatures) {
      Map<String, dynamic> prop = actData['properties'];
      dataList.add(await getTourDetails(prop['xid']));
    }
    return dataList;
  }

   */

  static Future<List<Tour>> getTourList(
      {int radius = 10000,
      required double lon,
      required double lat,
      int limit = 10}) async {
    final response = await Dio()
        .get('http://api.opentripmap.com/0.1/ru/places/radius?radius=$radius'
            '&lon=$lon&lat=$lat&limit=$limit&apikey=$tripKey');
    final data = response.data as Map<String, dynamic>;
    final dataFeatures = data['features'];

    List<Tour> dataList = [];
    for (Map<String, dynamic> actData in dataFeatures) {
      Map<String, dynamic> prop = actData['properties'];
      dataList.add(await getTourDetails(prop['xid']));
    }

    return dataList;
  }

  static Future<Tour> getTourDetails(String idEvent) async {
    final response = await Dio().get(
        'http://api.opentripmap.com/0.1/ru/places/xid/$idEvent?apikey=$tripKey');
    final data = response.data as Map<String, dynamic>;
    String id = data['xid'];
    Point coord = Point(data['point']['lon'], data['point']['lat']);
    String name = data['name'];
    //int rate = data['rate'];
    List<String> kinds = [];
    for (String el in data['kinds'].split(',')) {
      if (kindsMap[el] != null) {
        kinds.add(kindsMap[el]!);
      }
    }
    String image = data['image'] ?? '';

    Address address = Address(
        country: data['address']['country'] ?? '',
        city: data['address']['city'] ?? '',
        street: data['address']['road'] ?? '',
        house: data['address']['house_number'] ?? '');

    Map<String, dynamic>? info = data['info'];
    String? desc = info != null ? info['descr'] : null;
    return Tour(
        id: id,
        name: name,
        kinds: kinds,
        coordinates: coord,
        image: image,
        description: desc,
        address: address);
  }

  Future<List<AudioTour>> getAudioTourList(
      {required String city,
      required double lon,
      required double lat,
      int offset = 0}) async {
    int userId = await AuthService.loadUserId();
    final response = await Dio().get('$baseUrl/auth/tours/audio/city/$userId',
        queryParameters: {'city': city, 'offset': offset});
    if (response.statusCode == 404) {
      throw PathNotFoundException;
    } else if (response.statusCode == 403) {
      throw DioException.badResponse(
          statusCode: response.statusCode!,
          requestOptions: response.requestOptions,
          response: response);
    }
    final data = response.data as List<dynamic>;

    List<AudioTour> tours = [];
    for (Map<String, dynamic> actData in data) {
      tours.add(AudioTour.fromJson(actData));
    }
    return tours;
  }

  Future<List<AudioTour>> getCreatedTourList({int offset = 0}) async {
    final response = await Dio().get('$baseUrl/auth/admin/tours',
        queryParameters: {'offset': offset});
    if (response.statusCode == 404) {
      throw PathNotFoundException;
    } else if (response.statusCode == 403) {
      throw DioException.badResponse(
          statusCode: response.statusCode!,
          requestOptions: response.requestOptions,
          response: response);
    }
    final data = response.data as List<dynamic>;

    List<AudioTour> tours = [];
    for (Map<String, dynamic> actData in data) {
      tours.add(AudioTour.fromJson(actData));
    }
    return tours;
  }

  Future<List<AudioTour>> getCreatedTourListByUserId({int offset = 0}) async {
    int userId = await AuthService.loadUserId();
    final response = await Dio().get('$baseUrl/auth/tours/audio/$userId',
        queryParameters: {'offset': offset});
    if (response.statusCode == 404) {
      throw PathNotFoundException;
    } else if (response.statusCode == 403) {
      throw DioException.badResponse(
          statusCode: response.statusCode!,
          requestOptions: response.requestOptions,
          response: response);
    }
    final data = response.data as List<dynamic>;

    List<AudioTour> tours = [];
    for (Map<String, dynamic> actData in data) {
      tours.add(AudioTour.fromJson(actData));
    }
    return tours;
  }

  Future<void> likeTour(String id) async {
    final userId = await AuthService.loadUserId();

    final response = await Dio().put('$baseUrl/auth/users/likes',
        queryParameters: {"user_id": userId, "tour_id": int.parse(id)});

    if (response.statusCode == 202) {
      return;
    } else if (response.statusCode != null) {
      throw DioException.badResponse(
          statusCode: response.statusCode!,
          requestOptions: response.requestOptions,
          response: response);
    } else {
      throw Exception();
    }
  }

  Future<List<BaseTour>> getFavoriteTourList({int offset = 0}) async {
    int userId = await AuthService.loadUserId();
    final response = await Dio().get('$baseUrl/auth/users/likes/$userId');
    if (response.statusCode == 404) {
      throw PathNotFoundException;
    } else if (response.statusCode == 403) {
      throw DioException.badResponse(
          statusCode: response.statusCode!,
          requestOptions: response.requestOptions,
          response: response);
    }
    final data = response.data as List<dynamic>;

    List<BaseTour> tours = [];
    for (Map<String, dynamic> actData in data) {
      tours.add(BaseTour.fromJson(actData));
    }
    return tours;
  }

  Future<void> saveTour(
      final String name,
      final String imagePath,
      final List<Weekday> weekdays,
      final String description,
      final List<String> kinds,
      final Address address,
      final String audioPath,
      final File imageFile,
      final File audioFile) async {
    final userId = await AuthService.loadUserId();

    String imageFileName = imageFile.path.split('/').last;
    String audioFileName = audioFile.path.split('/').last;
    AudioTour tour = AudioTour(
        id: '',
        name: name,
        image: imageFileName,
        weekdays: weekdays,
        coordinates: const Point(38.5, 39.5),
        description: description,
        kinds: kinds,
        address: address,
        isLiked: false,
        audioFile: audioFileName);

    // final response = await Dio().post(
    //   '$baseUrl/auth/tours/audio/created/$userId',
    //   data: tour.toJson(),
    // );
    // if (response.statusCode == 404) {
    //   throw PathNotFoundException;
    // } else if (response.statusCode == 403) {
    //   throw DioException.badResponse(
    //       statusCode: response.statusCode!,
    //       requestOptions: response.requestOptions,
    //       response: response);
    // }

    // final formData = FormData.fromMap({
    //   "image":
    //   await MultipartFile.fromFile(imageFile.path, filename: imageFileName,),
    //   "audio":
    //       await MultipartFile.fromFile(audioFile.path, filename: audioFileName)
    // });
    // final formData = FormData.fromMap({
    //   "files": [
    //     MultipartFile.fromFileSync(imageFile.path, filename: imageFileName),
    //     MultipartFile.fromFileSync(audioFile.path, filename: audioFileName)
    //   ]
    // });
    Dio dio = Dio();
    List<MultipartFile> imageList = [];
    Uint8List imageData = imageFile.readAsBytesSync();
    MultipartFile multipartFile = MultipartFile.fromBytes(
      imageData,
      filename: imageFileName,
      contentType: MediaType("image", imageFileName.split('.').last),
    );
    imageList.add(multipartFile);
    FormData formData = FormData.fromMap({
      "multipartFiles": imageList,
    });
    // FormData formData = FormData.fromMap({
    //   "image": await MultipartFile.fromFile(imageFile.path,
    //       filename: imageFileName,
    //       contentType: MediaType("multipart", "form-data")),
    // });
    // final formData = FormData();
    // formData.files.addAll([
    //   MapEntry(
    //     'image',
    //     MultipartFile.fromFileSync(imageFile.path, filename: imageFileName),
    //   ),
    //   MapEntry(
    //     'audio',
    //     MultipartFile.fromFileSync(audioFile.path, filename: audioFileName),
    //   ),
    // ]);
    // int tourId = response.data;
    int tourId = 16;
    final response2 = await dio.post(
        '$baseUrl/auth/tours/audio/created/files/image/$tourId',
        data: formData
        //options: Options(headers: {'Content-Type': "multipart/form-data"}
        //)
    );

    // options: Options(
    //     headers: {'Accept': "*/*", 'Content-Type': "multipart/form-data"})

    // final formData = FormData.fromMap({
    //   'tour': tour.toJson(),
    //   "image":
    //       await MultipartFile.fromFile(imageFile.path, filename: imageFileName),
    //   "audio":
    //       await MultipartFile.fromFile(audioFile.path, filename: audioFileName)
    // });
    // final response = await Dio().post(
    //     '$baseUrl/auth/tours/audio/created/full/$userId',
    //     data: formData);
    // var request = http.MultipartRequest('POST',
    //     Uri.parse('$baseUrl/auth/tours/audio/created/files/image/$tourId'));
    // request.files.add(await http.MultipartFile.fromPath('image', imageFile.path,
    //     filename: imageFileName));
    //
    // var response2 = await request.send();
    if (response2.statusCode == 202) {
      return;
    } else if (response2.statusCode != null) {
      removeTour(tourId.toString());
      throw DioException.badResponse(
          statusCode: response2.statusCode!,
          requestOptions: response2.requestOptions,
          response: response2);
    }
  }

  Future<void> removeTour(String id) async {
    final response =
        await Dio().delete('$baseUrl/auth/tours/audio/${int.parse(id)}');

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 404) {
      throw PathNotFoundException;
    } else {
      throw Exception();
    }
  }
}
