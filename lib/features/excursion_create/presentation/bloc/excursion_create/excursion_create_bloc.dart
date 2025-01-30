import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/widgets/create_elements/create_elements.dart';
import 'package:good_trip/core/theme/strings.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

class ExcursionCreateBloc extends Bloc<ExcursionCreateEvent, ExcursionCreateState> {
  final IExcursionRepository excursionRepository;

  ExcursionCreateBloc({required this.excursionRepository}) : super(ExcursionCreateInitial()) {
    on<ExcursionCreateEvent>(
      (event, emit) async {
        if (event is ExcursionUpdateParamsRequested) {
          await _excursionUpdateParamRequested(event, emit);
        }
        if (event is ExcursionCreateRequested) {
          await _excursionCreateRequested(event, emit);
        }
        if (event is CreatedExcursionRemoveRequested) {
          await _excursionRemoveRequested(event, emit);
        }
        if (event is ExcursionUpdateAudioRequested) {}
      },
    );
  }

  Future<void> _excursionUpdateParamRequested(
      ExcursionUpdateParamsRequested event, Emitter<ExcursionCreateState> emit) async {
    emit(ExcursionCreateInProgress());
    try {
      late final IExcursion updatedTour;
      if (event.audioPath != null || event.tour is AudioExcursion) {
        final audioTour = event.tour as AudioExcursion;
        updatedTour = AudioExcursion(
          id: event.tour.id,
          name: event.name ?? audioTour.name,
          imageUrl: event.imagePath ?? audioTour.imageUrl,
          address: (event.address ?? audioTour.address) as Address,
          weekdays: event.weekdays ?? audioTour.weekdays,
          description: event.description ?? audioTour.description,
          kinds: event.kinds ?? audioTour.kinds,
          isLiked: false,
          audioUrl: event.audioPath ?? audioTour.audioUrl,
        );
      } else {
        updatedTour = Excursion(
          id: event.tour.id,
          name: event.name ?? event.tour.name,
          imageUrl: event.imagePath ?? event.tour.imageUrl,
          address: (event.address ?? event.tour.address) as Address,
          weekdays: event.weekdays ?? event.tour.weekdays,
          description: event.description ?? event.tour.description,
          kinds: event.kinds ?? event.tour.kinds,
          isLiked: false,
        );
      }
      emit(ExcursionUpdateParamSuccess(tour: updatedTour));
    } catch (e) {
      emit(const ExcursionCreateFailure(errorMsg: 'Error in weather request.'));
      AppMetrica.reportErrorWithGroup(
        'ExcursionCreate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
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
      AppMetrica.reportEvent('excursion_create');
      emit(ExcursionCreatedSuccess());
      _showChangeNotification(event.context, changesSuccess);
    } catch (e) {
      emit(const ExcursionCreateFailure(errorMsg: 'Error in tour create request.'));
      _showChangeNotification(event.context, changesFail);
      AppMetrica.reportErrorWithGroup(
        'ExcursionCreate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
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
