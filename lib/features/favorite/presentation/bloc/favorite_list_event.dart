import 'package:equatable/equatable.dart';

abstract class FavoriteListEvent extends Equatable {
  const FavoriteListEvent();
}

class FavoriteListRequested extends FavoriteListEvent {
  final int offset;

  const FavoriteListRequested({this.offset = 0,});

  @override
  List<Object> get props => [];
}