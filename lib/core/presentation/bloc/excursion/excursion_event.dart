import 'package:equatable/equatable.dart';
import 'package:good_trip/core/data/models/models.dart';

abstract class ExcursionEvent extends Equatable {
  const ExcursionEvent();
}

class ExcursionRequested extends ExcursionEvent {
  final Excursion excursion;

  const ExcursionRequested({required this.excursion});

  @override
  List<Object> get props => [excursion];
}

class ExcursionLikeRequested extends ExcursionEvent {
  final String id;

  const ExcursionLikeRequested({required this.id});

  @override
  List<Object> get props => [id];
}

class ExcursionSaveRequested extends ExcursionEvent {
  final AudioExcursion tour;

  const ExcursionSaveRequested({required this.tour});

  @override
  List<Object> get props => [tour];
}
