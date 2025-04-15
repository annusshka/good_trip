import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';

import 'kind_state.dart';

class KindCubit extends Cubit<KindState> {
  KindCubit() : super(const KindState(kindList: []));

  Future<void> selectKinds(String kind) async {
    try {
      List<TourType> kinds = List.from(state.kindList);
      final actualType = TourType.values.byName(kind);
      if (kinds.contains(actualType)) {
        kinds.remove(actualType);
      } else {
        kinds.add(actualType);
      }
      Map<String, String> attributesMap = {'kinds': kinds.toString()};
      AppMetrica.reportEventWithMap('select_kind', attributesMap);
      emit(KindState(kindList: kinds));
    } catch (e) {
      debugPrint('Error in kinds update request. ${e.toString()}');
      AppMetrica.reportErrorWithGroup(
        'ExcursionCreate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
