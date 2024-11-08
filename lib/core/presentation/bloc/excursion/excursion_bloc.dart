import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'excursion.dart';

class ExcursionBloc extends Bloc<ExcursionEvent, ExcursionState> {
  final IExcursionRepository excursionRepository;

  ExcursionBloc({required this.excursionRepository}) : super(ExcursionInitial()) {
    on<ExcursionEvent>(
      (event, emit) async {
        if (event is ExcursionLikeRequested) {
          await _requestExcursionLike(event, emit);
        }
        if (event is ExcursionSaveRequested) {
          await _requestExcursionSave(event, emit);
        }
      },
    );
  }

  Future<void> _requestExcursionLike(
      ExcursionLikeRequested event, Emitter<ExcursionState> emit) async {
    emit(ExcursionLoadInProgress());
    try {
      /// TODO: add user data layer
      final userId = 1;
      await excursionRepository.likeTour(userId: userId, id: event.id,);
      emit(ExcursionLikedSuccess());
    } catch (e) {
      emit(ExcursionListLoadFailure(errorMsg: e.toString()));
    }
  }

  Future<void> _requestExcursionSave(
      ExcursionSaveRequested event, Emitter<ExcursionState> emit) async {
    emit(ExcursionLoadInProgress());
    try {
      //await excursionRepository.saveExcursion(event.tour);
      emit(ExcursionLoadSuccess());
    } catch (e) {
      emit(ExcursionListLoadFailure(errorMsg: e.toString()));
    }
  }
}
