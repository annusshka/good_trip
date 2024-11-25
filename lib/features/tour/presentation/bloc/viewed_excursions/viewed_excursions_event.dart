import 'package:equatable/equatable.dart';

abstract class ViewedExcursionsEvent extends Equatable {
  const ViewedExcursionsEvent();
}

class ViewedExcursionRequested extends ViewedExcursionsEvent {
  final String tourId;

  const ViewedExcursionRequested({required this.tourId});

  @override
  List<Object> get props => [tourId];
}

class ViewExcursionRequested extends ViewedExcursionsEvent {
  final String tourId;
  final int excursionCount;
  final int actualCount;

  const ViewExcursionRequested({
    required this.tourId,
    required this.excursionCount,
    required this.actualCount,
  });

  @override
  List<Object> get props => [tourId];
}