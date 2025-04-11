import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'favorite_list_event.dart';
import 'favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  final IExcursionRepository tourRepository;

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
      final List<IExcursion> tours =
          await tourRepository.getFavoriteExcursionList(
        offset: event.offset,
      );
      AppMetrica.reportEvent('favourites_open');
      emit(FavoriteListLoadedSuccess(tourList: tours));
    } catch (e) {
      emit(
        const FavoriteListLoadFailure(
            errorMsg: 'Error in favoriteList request.'),
      );
      AppMetrica.reportErrorWithGroup(
        'FavouriteList level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }
}
