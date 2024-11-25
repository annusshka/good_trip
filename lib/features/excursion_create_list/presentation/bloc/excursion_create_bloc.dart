import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/widgets/create_elements/create_elements.dart';
import 'package:good_trip/core/theme/strings.dart';

import 'excursion_create.dart';

class ExcursionCreateBloc extends Bloc<ExcursionCreateEvent, ExcursionCreateState> {
  final IExcursionRepository excursionRepository;

  ExcursionCreateBloc({required this.excursionRepository}) : super(ExcursionCreateInitial()) {
    on<ExcursionCreateEvent>(
      (event, emit) async {
        if (event is ExcursionCreateRequested) {
          await _excursionCreateRequested(event, emit);
        }
        if (event is CreatedExcursionRemoveRequested) {
          await _excursionRemoveRequested(event, emit);
        }
      },
    );
  }

  Future<void> _excursionCreateRequested(
      ExcursionCreateRequested event, Emitter<ExcursionCreateState> emit) async {
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

  Future<void> _excursionRemoveRequested(
      CreatedExcursionRemoveRequested event, Emitter<ExcursionCreateState> emit) async {
    emit(ExcursionCreateInProgress());
    try {
      await excursionRepository.deleteExcursion(id: event.tourId);
      emit(ExcursionCreatedSuccess());
      _showChangeNotification(event.context, changesSuccess);
    } catch (_) {
      emit(const ExcursionCreateFailure(errorMsg: 'Error in tour create request.'));
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
