import 'package:audio_service/audio_service.dart';

/// Provides access to a library of media items. In your app, this could come
/// from a database or web service.
class MediaLibrary {
  static const albumsRootId = 'albums';

  final items = <String, List<MediaItem>>{
    // AudioService.browsableRootId: const [
    //   MediaItem(
    //     id: albumsRootId,
    //     title: 'Albums',
    //     playable: false,
    //   ),
    // ],
    //albumsRootId: [],
  };
}