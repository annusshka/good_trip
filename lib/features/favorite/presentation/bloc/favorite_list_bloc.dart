import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/domain/models/models.dart';

import '../../../../core/domain/service/service.dart';
import 'favorite_list_event.dart';
import 'favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {

  FavoriteListBloc() : super(FavoriteListInitial()) {
    on<FavoriteListEvent>((event, emit) async {
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
      final List<BaseTour> tours = await TourService()
          .getFavoriteTourList(offset: event.offset);
      emit(FavoriteListLoadedSuccess(tourList: tours));
    } catch (_) {
      emit(const FavoriteListLoadFailure(errorMsg: 'Error in favoriteList request.'));
    }
  }
}