import 'package:equatable/equatable.dart';

abstract class TourCreateListEvent extends Equatable {
  const TourCreateListEvent();

  @override
  List<Object> get props => [];
}

class TourCreateListRequested extends TourCreateListEvent {
  final int offset;

  const TourCreateListRequested({this.offset = 0});
}

class ToursCreateByActualUserRequested extends TourCreateListEvent {
  final int offset;

  const ToursCreateByActualUserRequested({this.offset = 0});
}