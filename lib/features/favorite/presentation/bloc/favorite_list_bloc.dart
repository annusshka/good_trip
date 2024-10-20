import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'favorite_list_event.dart';
import 'favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  final ITourRepository tourRepository;

  FavoriteListBloc({required this.tourRepository})
      : super(FavoriteListInitial()) {
    on<FavoriteListEvent>(
      (event, emit) async {
        if (event is FavoriteListRequested) {
          await _tourRequested(event, emit);
        }
      },
    );
  }

  Future<void> _tourRequested(
      FavoriteListRequested event, Emitter<FavoriteListState> emit) async {
    emit(FavoriteListLoadInProgress());
    try {
      ///TODO: add user data layer
      const userId = 1;
      final List<ITour> tours = await tourRepository.getFavoriteTourList(
        userId: userId,
        offset: event.offset,
      );
      emit(FavoriteListLoadedSuccess(tourList: tours));
    } catch (_) {
      emit(const FavoriteListLoadFailure(
          errorMsg: 'Error in favoriteList request.'));
    }
  }
}
