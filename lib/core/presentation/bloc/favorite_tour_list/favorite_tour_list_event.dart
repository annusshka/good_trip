import 'package:equatable/equatable.dart';

abstract class FavoriteTourListEvent extends Equatable {
  const FavoriteTourListEvent();
}

class FavoriteTourListRequested extends FavoriteTourListEvent {
  final int offset;

  const FavoriteTourListRequested({this.offset = 0,});

  @override
  List<Object> get props => [];
}