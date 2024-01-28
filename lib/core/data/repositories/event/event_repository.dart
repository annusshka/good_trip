import 'dart:math';
import 'package:dio/dio.dart';
import 'package:good_trip/core/data/models/models.dart';

import 'event.dart';

class EventRepository implements AbstractEventRepository{

  @override
  Future<List<Tour>> getTripEventList() async{
    final response = await Dio().get(
        'http://api.opentripmap.com/0.1/ru/places/bbox?'
            'lon_min=38.364285&lat_min=59.855685&lon_max=38.372809&'
            'lat_max=59.859052&format=geojson&limit=10&apikey=$tripKey');
    final data = response.data as Map<String, dynamic>;
    final dataFeatures = data['features'];
    List<Tour> dataList = [];
    for (Map<String, dynamic> actData in dataFeatures) {
      Map<String, dynamic> prop = actData['properties'];
      dataList.add(await getTripEvent(prop['xid']));
    }
    return dataList;
  }

  @override
  Future<Tour> getTripEvent(String idEvent) async{
    final response = await Dio().get(
        'http://api.opentripmap.com/0.1/ru/places/xid/$idEvent?apikey=$tripKey');
    final data = response.data as Map<String, dynamic>;
    String id = data['xid'];
    Point coord = Point(data['point']['lon'], data['point']['lat']);
    String name = data['name'];
    //int rate = data['rate'];
    List<String> kinds = data['kinds'].split(',');
    String image = data['image'];
    Map<String, dynamic>? info = data['info'];
    String? desc = info != null ? info['descr'] : null;
    return Tour(id: id, name: name, kinds: kinds, coordinates: coord,
        image: image, description: desc);
  }
}