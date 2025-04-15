import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/map/map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapState(point: null));

  void selectPoint(final Point point) {
    emit(MapState(point: point));
  }
}
