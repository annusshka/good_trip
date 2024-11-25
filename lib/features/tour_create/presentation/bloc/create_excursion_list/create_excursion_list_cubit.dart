import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/create_excursion_list/create_excursion_list_state.dart';

class CreateExcursionListCubit extends Cubit<CreateExcursionListState> {
  CreateExcursionListCubit()
      : super(const CreateExcursionListState(excursionList: []));

  void createExcursionList(final IExcursion newExcursion) {
    List<IExcursion> excursionList = List.from(state.excursionList);
    excursionList.add(newExcursion);
    emit(CreateExcursionListState(excursionList: excursionList,));
  }
}