// import 'package:audio_service/audio_service.dart';
// import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
// import 'package:good_trip/core/data/models/models.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';
//
// class ExcursionListPresenter {
//   final AudioPlayerHandler audioPlayerHandler;
//   final List<IAudioExcursion> excursionList;
//   final String tourName;
//
//   ExcursionListPresenter({
//     required this.audioPlayerHandler,
//     required this.excursionList,
//     required this.tourName,
//   });
//
//   final BehaviorSubject<List<MediaItem>> mediaItemList =
//       BehaviorSubject.seeded([]);
//
//   Future<void> init() async {
//     final List<MediaItem> mediaItems =
//         await excursionsToMediaItems(excursionList as List<AudioExcursion>);
//     mediaItemList.add(mediaItems);
//     audioPlayerHandler.loadPlaylist(mediaItemList.valueOrNull ?? [], tourName);
//   }
//
//   Future<List<MediaItem>> excursionsToMediaItems(
//     List<AudioExcursion> excursions,
//   ) async {
//     List<MediaItem> items = [];
//     for (final AudioExcursion excursion in excursions) {
//       final audioDuration = await AudioPlayer().setUrl(excursion.audioUrl);
//       final item = MediaItem(
//         id: excursion.audioUrl,
//         title: excursion.name,
//         album: tourName,
//         duration: audioDuration,
//         artUri: Uri.tryParse(excursion.imageUrl ?? ''),
//       );
//       items.add(item);
//     }
//     return items;
//   }
//
//   void dispose() {
//     mediaItemList.close();
//   }
// }
