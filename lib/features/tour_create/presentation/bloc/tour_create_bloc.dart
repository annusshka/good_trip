import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/service/service.dart';

import 'tour_create.dart';

class TourCreateBloc extends Bloc<TourCreateEvent, TourCreateState> {
  final ITourRepository tourRepository;

  TourCreateBloc({required this.tourRepository}) : super(TourCreateInitial()) {
    on<TourCreateEvent>(
      (event, emit) async {
        if (event is TourCreateRequested) {
          await _tourCreateRequested(event, emit);
        }
        if (event is CreatedTourRemoveRequested) {
          await _tourRemoveRequested(event, emit);
        }
      },
    );
  }

  Future<void> _tourCreateRequested(
      TourCreateRequested event, Emitter<TourCreateState> emit) async {
    emit(TourCreateInProgress());
    try {
      ///TODO: saveTour method

      // await tourRepository.saveTour(
      //   event.name,
      //   event.imagePath,
      //   event.weekdays,
      //   event.description,
      //   event.kinds,
      //   event.address,
      //   event.audioPath,
      //   event.imageFile,
      //   event.audioFile,
      // );
      emit(TourCreatedSuccess());
    } catch (_) {
      emit(const TourCreateFailure(errorMsg: 'Error in weather request.'));
    }
  }

  Future<void> _tourRemoveRequested(
      CreatedTourRemoveRequested event, Emitter<TourCreateState> emit) async {
    emit(TourCreateInProgress());
    try {
      await tourRepository.deleteTour(id: event.tourId);
      emit(TourCreatedSuccess());
    } catch (_) {
      emit(const TourCreateFailure(errorMsg: 'Error in weather request.'));
    }
  }
}
