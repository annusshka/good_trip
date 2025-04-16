import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/favorite_excursion/favorite_excursion.dart';

class FavouriteExcursionCubit extends Cubit<FavouriteExcursionState> {
  final IExcursionRepository excursionRepository;

  FavouriteExcursionCubit({required this.excursionRepository})
      : super(const FavouriteExcursionState(favouriteAudioExcursionList: []));

  Future<void> favouriteAudioExcursionsRequested({int offset = 0}) async {
    emit(const FavouriteExcursionState(favouriteAudioExcursionList: null));
    try {
      final List<AudioExcursion> excursions = await excursionRepository.getFavoriteExcursionList(offset: offset);
      AppMetrica.reportEvent('favourites_tour_open');
      emit(FavouriteExcursionState(favouriteAudioExcursionList: excursions));
    } catch (e) {
      emit(const FavouriteExcursionState(favouriteAudioExcursionList: null));
      AppMetrica.reportErrorWithGroup(
        'FavouriteList level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  Future<bool> likeAudioExcursion({
    required AudioExcursion excursion,
    required bool isLiked,
    required List<AudioExcursion>? excursionList,
  }) async {
    try {
      await excursionRepository.likeAudioExcursion(id: excursion.id, isLiked: isLiked);
      Map<String, String> attributesMap = {'tour_id': excursion.id};
      AppMetrica.reportEventWithMap('tour_like', attributesMap);
      if (isLiked) {
        excursionList?.add(excursion);
      } else {
        excursionList?.remove(excursion);
      }
      emit(FavouriteExcursionState(favouriteAudioExcursionList: excursionList));
      return true;
    } catch (e) {
      AppMetrica.reportErrorWithGroup(
        'Tour level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
      return false;
    }
  }
}
