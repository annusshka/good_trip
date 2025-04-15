// import 'package:audio_service/audio_service.dart';
// import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
// import 'package:good_trip/core/audio_player/data/position_data.dart';
// import 'package:rxdart/rxdart.dart';
//
// class ExcursionCardPresenter {
//   final int index;
//   final AudioPlayerHandler audioPlayerHandler;
//
//   ExcursionCardPresenter({
//     required this.index,
//     required this.audioPlayerHandler,
//   });
//
//   final BehaviorSubject<bool> isActualAudio = BehaviorSubject.seeded(false);
//   late final BehaviorSubject<MediaItem?> mediaItem = BehaviorSubject();
//   late final BehaviorSubject<PlaybackState> playbackState = BehaviorSubject();
//
//   Stream<Duration> get bufferedPositionStream =>
//       audioPlayerHandler.playbackState
//           .map((state) => state.bufferedPosition)
//           .distinct();
//
//   Stream<Duration?> get durationStream =>
//       mediaItem.map((item) => item?.duration).distinct();
//
//   Stream<PositionData> get positionDataStream =>
//       Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
//         AudioService.position,
//         bufferedPositionStream,
//         durationStream,
//         (position, bufferedPosition, duration) => PositionData(
//           position,
//           bufferedPosition,
//           duration ?? Duration.zero,
//         ),
//       );
//
//   Future<void> init() async {
//     audioPlayerHandler.currentIndex.listen((actualIndex) async {
//       if (audioPlayerHandler.actualAlbum == audioPlayerHandler.loadedAlbum) {
//         isActualAudio.add(index == actualIndex);
//       }
//     });
//
//     audioPlayerHandler.loadedPlaylist.listen((loadedPlayList) {
//       if (index < loadedPlayList.length) {
//         mediaItem.add(loadedPlayList[index]);
//       }
//     });
//   }
//
//   bool checkIndex(int? i) {
//     return false;
//   }
//
//   Future<void> playNewAudio() async {
//     await audioPlayerHandler.playNewAudio(index);
//   }
//
//   void pause() {
//     audioPlayerHandler.pause();
//   }
//
//   void dispose() {
//     isActualAudio.close();
//     mediaItem.close();
//     playbackState.close();
//   }
// }
