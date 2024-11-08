import 'package:equatable/equatable.dart';

abstract class ExcursionCreateListEvent extends Equatable {
  const ExcursionCreateListEvent();

  @override
  List<Object> get props => [];
}

class ExcursionCreateListRequested extends ExcursionCreateListEvent {
  final int offset;

  const ExcursionCreateListRequested({this.offset = 0});
}

class ExcursionListCreateByActualUserRequested extends ExcursionCreateListEvent {
  final int offset;

  const ExcursionListCreateByActualUserRequested({this.offset = 0});
}

class ShowNotificationRequested extends ExcursionCreateListEvent {}
