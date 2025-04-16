import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/mapper/mapper_export.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

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

  Future<void> _excursionCreateRequested(ExcursionCreateRequested event, Emitter<ExcursionCreateState> emit) async {
    emit(ExcursionCreateInProgress());
    try {
      if (event.audioFile == null || event.imageFile == null) {
        emit(const ExcursionCreateFailure(errorMsg: 'Empty param in tour create request.'));
      } else {
        final imageName = event.imagePath.split('/').last;
        final audioName = event.audioPath.split('/').last;
        final weekDays = event.weekdays.map((e) => Weekday.values.firstWhere((el) => el.name == e.dayKey)).toList();
        final AudioExcursionDto audioExcursion = AudioExcursionDto(
          name: event.name,
          imagePath: imageName,
          weekdays: weekDays,
          description: event.description,
          kinds: mapFromTourType(event.kinds),
          address: mapAddressToDto(event.address),
          audioPath: audioName,
        );
        await excursionRepository.saveExcursion(
          audioExcursion: audioExcursion,
          imagePath: event.imagePath,
          audioPath: event.audioPath,
        );
        emit(ExcursionCreatedSuccess());
      }
    } catch (e) {
      emit(const ExcursionCreateFailure(errorMsg: 'Error in excursion create request.'));
      AppMetrica.reportErrorWithGroup(
        'ExcursionCreate level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  Future<void> _excursionRemoveRequested(
      CreatedExcursionRemoveRequested event, Emitter<ExcursionCreateState> emit) async {
    emit(ExcursionRemoveInProgress());
    try {
      await excursionRepository.deleteExcursion(id: event.excursionId);
      AppMetrica.reportEvent('excursion_deleted ${event.excursionId}');
      emit(ExcursionRemovedSuccess());
    } catch (e) {
      emit(const ExcursionRemoveFailure(errorMsg: 'Error in excursion create request.'));
      AppMetrica.reportErrorWithGroup(
        'ExcursionCreatedRemove level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
