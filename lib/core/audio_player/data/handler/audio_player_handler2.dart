import 'package:audio_service/audio_service.dart';
import 'package:good_trip/core/audio_player/data/handler/queue_state2.dart';
import 'package:good_trip/core/audio_player/data/queue_state.dart';

/// Класс [AudioHandler] представляет интерфейс для проигрывания плейлиста
abstract class AudioPlayerHandler2 implements AudioHandler {
  Stream<QueueState2> get queueState;
}