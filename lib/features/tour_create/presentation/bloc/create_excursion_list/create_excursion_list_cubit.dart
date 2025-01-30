import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/create_excursion_list/create_excursion_list_state.dart';

class CreateExcursionListCubit extends Cubit<CreateExcursionListState> {
  CreateExcursionListCubit()
      : super(const CreateExcursionListState(excursionList: []));

  void createExcursionList(final AudioExcursion newExcursion) {
    List<AudioExcursion> excursionList = List.from(state.excursionList);
    excursionList.add(newExcursion);
    AppMetrica.reportEvent('created_excursion_list_loaded');
    emit(CreateExcursionListState(excursionList: excursionList,));
  }
}