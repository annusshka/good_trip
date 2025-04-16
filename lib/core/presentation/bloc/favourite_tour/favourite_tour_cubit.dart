import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/favourite_tour/favourite_tour_state.dart';

class FavouriteTourCubit extends Cubit<FavouriteTourState> {
  final ITourRepository tourRepository;

  FavouriteTourCubit({required this.tourRepository}) : super(const FavouriteTourState(favouriteTourList: []));

  Future<void> favouriteTourListRequested({int offset = 0}) async {
    emit(const FavouriteTourState(favouriteTourList: null));
    try {
      final List<Tour> tours = await tourRepository.getFavoriteTours(offset: offset);
      AppMetrica.reportEvent('favourites_tour_open');
      emit(FavouriteTourState(favouriteTourList: tours));
    } catch (e) {
      emit(const FavouriteTourState(favouriteTourList: null));
      AppMetrica.reportErrorWithGroup(
        'FavouriteList level',
        message: e.toString(),
        errorDescription: AppMetricaErrorDescription(StackTrace.current),
      );
    }
  }

  Future<bool> likeTour({required Tour tour, required bool isLiked, required List<Tour>? tourList}) async {
    try {
      await tourRepository.likeTour(id: tour.id, isLiked: isLiked);
      Map<String, String> attributesMap = {'tour_id': tour.id};
      AppMetrica.reportEventWithMap('tour_like', attributesMap);
      if (isLiked) {
        tourList?.add(tour);
      } else {
        tourList?.remove(tour);
      }
      emit(FavouriteTourState(favouriteTourList: tourList));
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
