import 'package:equatable/equatable.dart';
import 'package:good_trip/features/welcome/data/models/welcome_info/welcome_info.dart';

abstract class WelcomeInfoState extends Equatable {
  const WelcomeInfoState();

  @override
  List<Object> get props => [];
}

class WelcomeInfoInitial extends WelcomeInfoState {}

class WelcomeInfoInProgress extends WelcomeInfoState {}

class WelcomeInfoSuccess extends WelcomeInfoState {
  final List<WelcomeInfo>? welcomeInfoList;

  const WelcomeInfoSuccess({required this.welcomeInfoList});
}

class WelcomeInfoFailure extends WelcomeInfoState {
  final String errorMsg;

  const WelcomeInfoFailure({required this.errorMsg});
}
