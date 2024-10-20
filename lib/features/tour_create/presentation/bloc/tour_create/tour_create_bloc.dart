import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/theme/strings.dart';
import 'package:good_trip/di/configure_dependencies.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';
import 'package:good_trip/features/tour_create/presentation/widgets/widgets.dart';

class TourCreateBloc extends Bloc<TourCreateEvent, TourCreateState> {
  final ITourRepository tourRepository;

  TourCreateBloc({required this.tourRepository}) : super(TourCreateInitial()) {
    on<TourCreateEvent>(
      (event, emit) async {
        if (event is TourUpdateParamsRequested) {
          await _tourUpdateParamRequested(event, emit);
        }
        if (event is TourCreateRequested) {
          await _tourCreateRequested(event, emit);
        }
        if (event is CreatedTourRemoveRequested) {
          await _tourRemoveRequested(event, emit);
        }
        if (event is TourUpdateAudioRequested) {}
      },
    );
  }

  Future<void> _tourUpdateParamRequested(
      TourUpdateParamsRequested event, Emitter<TourCreateState> emit) async {
    emit(TourCreateInProgress());
    try {
      late final ITour updatedTour;
      if (event.audioPath != null || event.tour is AudioTour) {
        final audioTour = event.tour as AudioTour;
        updatedTour = AudioTour(
          id: event.tour.id,
          name: event.name ?? audioTour.name,
          image: event.imagePath ?? audioTour.image,
          address: (event.address ?? audioTour.address) as Address,
          weekdays: event.weekdays ?? audioTour.weekdays,
          description: event.description ?? audioTour.description,
          kinds: event.kinds ?? audioTour.kinds,
          isLiked: false,
          audio: event.audioPath ?? audioTour.audio,
        );
      } else {
        updatedTour = Tour(
          id: event.tour.id,
          name: event.name ?? event.tour.name,
          image: event.imagePath ?? event.tour.image,
          address: (event.address ?? event.tour.address) as Address,
          weekdays: event.weekdays ?? event.tour.weekdays,
          description: event.description ?? event.tour.description,
          kinds: event.kinds ?? event.tour.kinds,
          isLiked: false,
        );
      }
      emit(TourUpdateParamSuccess(tour: updatedTour));
    } catch (_) {
      emit(const TourCreateFailure(errorMsg: 'Error in weather request.'));
    }
  }

  Future<void> _tourCreateRequested(
      TourCreateRequested event, Emitter<TourCreateState> emit) async {
    // final WeekdayCubit weekdayCubit = getIt.get<WeekdayCubit>();
    // final AudioState audioState = event.context.read<AudioState>();
    // final ImageState imageState = event.context.read<ImageState>();
    // final KindState kindState = event.context.read<KindState>();
    // final WeekdayState weekdayState = event.context.read<WeekdayState>();
    //
    // emit(TourCreateInProgress());
    // try {
    //   if (audioState.audio == null ||
    //       audioState.audioPath == null ||
    //       imageState.image == null ||
    //       imageState.imagePath == null ||
    //       kindState.kinds.isEmpty ||
    //       weekdayState.days.isEmpty) {
    //     emit(
    //       const TourCreateFailure(
    //           errorMsg: 'Empty param in tour create request.'),
    //     );
    //     _showChangeNotification(
    //       event.context,
    //       'Проверьте все ли поля заполнены!',
    //     );
    //   } else {
    //     ///TODO: saveTour method
    //     // await tourRepository.saveTour(
    //     //   event.name,
    //     //   event.imagePath,
    //     //   event.weekdays,
    //     //   event.description,
    //     //   event.kinds,
    //     //   event.address,
    //     //   event.audioPath,
    //     //   event.imageFile,
    //     //   event.audioFile,
    //     // );
    //     emit(TourCreatedSuccess());
    //     weekdayCubit.clearWeekdays();
    //     _showChangeNotification(event.context, changesSuccess);
    //   }
    // } catch (_) {
    //   emit(const TourCreateFailure(errorMsg: 'Error in tour create request.'));
    //   _showChangeNotification(event.context, changesFail);
    // }
  }

  Future<void> _tourRemoveRequested(
      CreatedTourRemoveRequested event, Emitter<TourCreateState> emit) async {
    emit(TourCreateInProgress());
    try {
      await tourRepository.deleteTour(id: event.tourId);
      emit(TourCreatedSuccess());
      _showChangeNotification(event.context, changesSuccess);
    } catch (_) {
      emit(const TourCreateFailure(errorMsg: 'Error in tour create request.'));
      _showChangeNotification(event.context, changesFail);
    }
  }

  Future<void> _showChangeNotification(context, String text) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppNotification(text: text);
      },
    );
  }
}
