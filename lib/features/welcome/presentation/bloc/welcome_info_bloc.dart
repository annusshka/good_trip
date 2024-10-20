import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart';

import 'welcome_info.dart';

class WelcomeInfoBloc extends Bloc<WelcomeInfoEvent, WelcomeInfoState> {
  final IWelcomeInfoRepository welcomeInfoRepository;

  WelcomeInfoBloc({required this.welcomeInfoRepository})
      : super(WelcomeInfoInitial()) {
    on<WelcomeInfoEvent>(
      (event, emit) async {
        if (event is CheckFirstRun) {
          await _checkIsFirstRun(event, emit);
        }
        if (event is WelcomeInfoRequested) {
          await _getWelcomeInfoRequested(event, emit);
        }
        if (event is SetFirstRun) {
          await _setFirstRun(event, emit);
        }
      },
    );
  }

  Future<void> _getWelcomeInfoRequested(
      WelcomeInfoRequested event, Emitter<WelcomeInfoState> emit) async {
    emit(WelcomeInfoInProgress());
    try {
      final response = await welcomeInfoRepository.getWelcomeInfo();
      emit(WelcomeInfoSuccess(welcomeInfoList: response));
    } catch (_) {
      emit(
          const WelcomeInfoFailure(errorMsg: 'Error in welcome info request.'));
    }
  }

  Future<void> _checkIsFirstRun(
      CheckFirstRun event, Emitter<WelcomeInfoState> emit) async {
    emit(WelcomeInfoInProgress());
    try {
      final response = await welcomeInfoRepository.checkFirstRun();
      if (response) {
        emit(WelcomeInfoAlreadySeen());
      } else {
        add(const WelcomeInfoRequested());
      }
    } catch (_) {
      emit(const WelcomeInfoFailure(
          errorMsg: 'Error in check first run request.'));
    }
  }

  Future<void> _setFirstRun(
      SetFirstRun event, Emitter<WelcomeInfoState> emit) async {
    emit(WelcomeInfoInProgress());
    try {
      await welcomeInfoRepository.setFirstRun();
      emit(FirstRun());
    } catch (_) {
      emit(const WelcomeInfoFailure(
          errorMsg: 'Error in check first run request.'));
    }
  }
}
