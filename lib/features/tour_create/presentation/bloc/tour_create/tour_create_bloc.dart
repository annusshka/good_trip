import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/widgets/create_elements/create_elements.dart';
import 'package:good_trip/core/theme/strings.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create/tour_create.dart';

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
      if (event.imageFile == null ||
          event.imagePath.isEmpty ||
          event.kinds.isEmpty ||
          event.weekdays.isEmpty ||
          event.excursionList.isEmpty) {
        emit(
          const TourCreateFailure(
              errorMsg: 'Empty param in tour create request.'),
        );
      } else {
        await tourRepository.saveTour(
          name: event.name,
          imagePath: event.imagePath,
          weekdays: event.weekdays,
          description: event.description,
          kinds: event.kinds,
          address: event.address,
          imageFile: event.imageFile,
          excursionList: event.excursionList,
        );
        emit(TourCreatedSuccess());
      }
    } catch (_) {
      emit(const TourCreateFailure(errorMsg: 'Error in tour create request.'));
    }

    // final WeekdayCubit weekdayCubit = getIt.get<WeekdayCubit>();
    // final AudioState audioState = event.context.read<AudioSta
    // te>();
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
