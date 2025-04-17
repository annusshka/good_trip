import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/audio_player/data/handler/audio_player_handler.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/audio_list/audio_list.dart';
import 'package:just_audio/just_audio.dart';

class AudioListCubit extends Cubit<AudioListState> {
  final AudioPlayerHandler audioPlayerHandler;
  final AudioPlayer audioPlayer;

  AudioListCubit({required this.audioPlayerHandler, required this.audioPlayer})
      : super(const AudioListState(mediaItemList: []));

  Future<void> init({required List<IAudioExcursion> excursionList, required String tourName}) async {
    final List<MediaItem> mediaItems = await excursionsToMediaItems(excursionList as List<AudioExcursion>, tourName);
    audioPlayerHandler.loadPlaylist(mediaItems, tourName);
    AppMetrica.reportEvent('load audio_tour $tourName');
    emit(AudioListState(mediaItemList: mediaItems));
  }

  Future<List<MediaItem>> excursionsToMediaItems(List<AudioExcursion> excursions, String tourName) async {
    List<MediaItem> items = [];
    for (final AudioExcursion excursion in excursions) {
      final audioDuration = await audioPlayer.setUrl(excursion.audioUrl);
      final item = MediaItem(
        id: excursion.audioUrl,
        title: excursion.name,
        album: tourName,
        duration: audioDuration,
        artUri: Uri.tryParse(excursion.imageUrl ?? ''),
      );
      items.add(item);
    }
    return items;
  }
}
