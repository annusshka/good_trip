import 'package:equatable/equatable.dart';

abstract class WelcomeInfoEvent extends Equatable {
  const WelcomeInfoEvent();

  @override
  List<Object> get props => [];
}

class WelcomeInfoRequested extends WelcomeInfoEvent {
  const WelcomeInfoRequested();
}

class CheckFirstRun extends WelcomeInfoRequested {
  const CheckFirstRun();
}

class SetFirstRun extends WelcomeInfoRequested {
  const SetFirstRun();
}
