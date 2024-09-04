import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart';

import 'welcome_info.dart';

class WelcomeInfoBloc extends Bloc<WelcomeInfoEvent, WelcomeInfoState> {
  final IWelcomeInfoRepository welcomeInfoRepository;

  WelcomeInfoBloc({required this.welcomeInfoRepository})
      : super(WelcomeInfoInitial()) {
    on<WelcomeInfoEvent>(
      (event, emit) async {
        if (event is WelcomeInfoRequested) {
          await _tourCreateRequested(event, emit);
        }
      },
    );
  }

  Future<void> _tourCreateRequested(
      WelcomeInfoRequested event, Emitter<WelcomeInfoState> emit) async {
    emit(WelcomeInfoInProgress());
    try {
      final response = await welcomeInfoRepository.getWelcomeInfo();
      emit(WelcomeInfoSuccess(welcomeInfoList: response));
    } catch (_) {
      emit(const WelcomeInfoFailure(errorMsg: 'Error in welcome info request.'));
    }
  }
}
