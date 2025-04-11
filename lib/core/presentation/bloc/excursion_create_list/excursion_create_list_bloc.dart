import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'excursion_create_list.dart';

class ExcursionCreateListBloc
    extends Bloc<ExcursionCreateListEvent, ExcursionCreateListState> {
  final IExcursionRepository excursionRepository;

  ExcursionCreateListBloc({required this.excursionRepository}) : super(ExcursionCreateListInitial()) {
    on<ExcursionCreateListEvent>(
      (event, emit) async {
        if (event is ExcursionCreateListRequested) {
          await _excursionCreatedListRequested(event, emit);
        } else if (event is ExcursionListCreateByActualUserRequested) {
          await _excursionListCreatedByActualUserRequested(event, emit);
        }
      },
    );
  }

  Future<void> _excursionCreatedListRequested(
      ExcursionCreateListRequested event, Emitter<ExcursionCreateListState> emit) async {
    emit(ExcursionCreateListLoadInProgress());
    try {
      final List<AudioExcursion> tours =
          await excursionRepository.getCreatedExcursionListByAdmin(offset: event.offset);
      emit(ExcursionCreateListLoadedSuccess(excursionList: tours));
    } catch (e) {
      emit(const ExcursionCreateListLoadFailure(
          errorMsg: 'Error in created tours request.'));
      AppMetrica.reportErrorWithGroup(
        'TourCreate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  Future<void> _excursionListCreatedByActualUserRequested(
      ExcursionListCreateByActualUserRequested event,
      Emitter<ExcursionCreateListState> emit) async {
    emit(ExcursionCreateListLoadInProgress());
    try {
      final List<AudioExcursion> tours =
          await excursionRepository.getCreatedExcursionListByUserId(
        offset: event.offset,
      );
      emit(ExcursionCreateListLoadedSuccess(excursionList: tours));
    } catch (e) {
      emit(const ExcursionCreateListLoadFailure(
          errorMsg: 'Error in created tours request.'));
      AppMetrica.reportErrorWithGroup(
        'TourCreate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
