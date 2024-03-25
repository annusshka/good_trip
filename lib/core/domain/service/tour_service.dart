import 'dart:math';
import 'package:dio/dio.dart';

import '../../data/api/api_key.dart';
import '../models/tour.dart';

class TourService{

  static Map<String, String> kindsMap = {'accomodations': 'Жильё',
    'adult': 'Для взрослых', 'amusements': 'Развлечения',
    'interesting_places': 'Интересные места', 'cultural': 'Культура',
    'architecture': 'Архитектура', 'museums': 'Музей',
    'theatres_and_entertainments': 'Театр и развлечения',
    'archaeology': 'Археология', 'burial_places': 'Место захоронений',
    'monuments_and_memorials': 'Монументы и мемориалы',
    'natural': 'Природа', 'beaches': 'Пляж',
    'geological_formations': 'Геологическая порода', 'islands': 'Остров',
    'natural_springs': 'Естественный источник',
    'nature_reserves': 'Заповедник', 'water': 'Вода', 'religion': 'Религия',
    'sport': 'Спорт', 'climbing': 'Скалолазание',
    'diving': 'Дайвинг', 'winter_sports': 'Зимний спорт', 'banks': 'Банк',
    'foods': 'Еда', 'shops': 'Магазин', 'transport': 'Транспорт'};

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

  static Future<List<Tour>> getTourList({int radius = 10000,
    required String lon, required String lat, int limit = 10}) async{
    final response = await Dio().get(
        'http://api.opentripmap.com/0.1/ru/places/radius?radius=$radius'
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

  static Future<Tour> getTourDetails(String idEvent) async{
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

    List<String> address = [];
    address.add(data['address']['country'] ?? '');
    address.add(data['address']['city'] ?? '');
    address.add(data['address']['road'] ?? '');
    address.add(data['address']['house_number'] ?? '');

    Map<String, dynamic>? info = data['info'];
    String? desc = info != null ? info['descr'] : null;
    return Tour(id: id, name: name, kinds: kinds, coordinates: coord,
        image: image, description: desc, address: address);
  }
}