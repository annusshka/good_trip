import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';

import 'favorite_excursion_list_event.dart';
import 'favorite_excursion_list_state.dart';

class FavoriteExcursionListBloc extends Bloc<FavoriteExcursionListEvent, FavoriteExcursionListState> {
  final IExcursionRepository excursionRepository;

  FavoriteExcursionListBloc({required this.excursionRepository})
      : super(FavoriteExcursionListInitial()) {
    on<FavoriteExcursionListEvent>(
      (event, emit) async {
        if (event is FavoriteExcursionListRequested) {
          await _tourRequested(event, emit);
        }
      },
    );
  }

  Future<void> _tourRequested(
      FavoriteExcursionListRequested event, Emitter<FavoriteExcursionListState> emit) async {
    emit(FavoriteExcursionListLoadInProgress());
    try {
      final List<IExcursion> excursionList =
          await excursionRepository.getFavoriteExcursionList(
        offset: event.offset,
      );
      AppMetrica.reportEvent('favourites_open');
      emit(FavoriteExcursionListLoadedSuccess(excursionList: excursionList));
    } catch (e) {
      emit(
        const FavoriteExcursionListLoadFailure(
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
