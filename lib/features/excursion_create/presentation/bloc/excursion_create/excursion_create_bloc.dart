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
          address: (event.address ?? audioTour.address),
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

  Future<void> _excursionCreateRequested(ExcursionCreateRequested event, Emitter<ExcursionCreateState> emit) async {
    emit(ExcursionCreateInProgress());
    try {
      if (event.audioFile == null || event.imageFile == null) {
        emit(
          const ExcursionCreateFailure(errorMsg: 'Empty param in tour create request.'),
        );
      } else {
        final weekDays = event.weekdays.map((e) => Weekday.values.firstWhere((el) => el.name == e.dayKey)).toList();
        final AudioExcursion audioExcursion = AudioExcursion(
          id: '0',
          name: event.name,
          imageUrl: event.imagePath,
          weekdays: weekDays,
          description: event.description,
          kinds: event.kinds,
          address: event.address,
          audioUrl: event.audioPath,
        );
        await excursionRepository.saveExcursion(
          audioExcursion: audioExcursion,
        );
        emit(ExcursionCreatedSuccess());
      }
    } catch (_) {
      emit(const ExcursionCreateFailure(errorMsg: 'Error in tour create request.'));
    }
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
