import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/repositories/event/event.dart';

class EventRepository implements AbstractEventRepository{

  @override
  Future<List<Event>> getTripEventList() async{
    final response = await Dio().get(
        'http://api.opentripmap.com/0.1/ru/places/bbox?'
            'lon_min=38.364285&lat_min=59.855685&lon_max=38.372809&'
            'lat_max=59.859052&format=geojson&limit=10&apikey=$tripKey');
    final data = response.data as Map<String, dynamic>;
    final dataFeatures = data['features'];
    List<Event> dataList = [];
    for (Map<String, dynamic> actData in dataFeatures) {
      Map<String, dynamic> prop = actData['properties'];
      dataList.add(await getTripEvent(prop['xid']));
      /*
      Point coord = Point(actData['geometry']['coordinates'][0], actData['geometry']['coordinates'][1]);
      Map<String, dynamic> prop = actData['properties'];
      String id = prop['xid'];
      String name = prop['name'];
      int rate = prop['rate'];
      List<String> kinds = prop['kinds'].split(',');
      dataList.add(Event(id: id, name: name, kinds: kinds, coordinates: coord));

       */
    }
    return dataList;
  }

  @override
  Future<Event> getTripEvent(String idEvent) async{
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
    return Event(id: id, name: name, kinds: kinds, coordinates: coord,
        image: image, description: desc);
  }
}