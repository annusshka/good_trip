// import 'package:appmetrica_plugin/appmetrica_plugin.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:good_trip/core/data/models/models.dart';
// import 'package:good_trip/core/data/repository/repository.dart';
//
// import 'favorite_tour_list_event.dart';
// import 'favorite_tour_list_state.dart';
//
// class FavoriteTourListBloc extends Bloc<FavoriteTourListEvent, FavoriteTourListState> {
//   final ITourRepository tourRepository;
//
//   FavoriteTourListBloc({required this.tourRepository}) : super(const FavoriteTourListInitial()) {
//     on<FavoriteTourListEvent>(
//       (event, emit) async {
//         if (event is FavoriteTourListRequested) {
//           await _tourRequested(event, emit);
//         }
//       },
//     );
//   }
//
//   Future<void> _tourRequested(FavoriteTourListRequested event, Emitter<FavoriteTourListState> emit) async {
//     emit(const FavoriteTourListLoadInProgress());
//     try {
//       final List<ITour> tours = await tourRepository.getFavoriteTours(
//         offset: event.offset,
//       );
//       AppMetrica.reportEvent('favourites_tour_open');
//       emit(FavoriteTourListLoadedSuccess(tourList: tours));
//     } catch (e) {
//       emit(const FavoriteTourListLoadFailure(errorMsg: 'Error in favoriteTourList request.'));
//       AppMetrica.reportErrorWithGroup(
//         'FavouriteList level',
//         message: e.toString(),
//         errorDescription: AppMetricaErrorDescription(StackTrace.current),
//       );
//     }
//   }
// }
