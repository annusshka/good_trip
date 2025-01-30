import 'package:audio_service/audio_service.dart';
import 'package:good_trip/core/audio_player/data/queue_state.dart';
import 'package:rxdart/rxdart.dart';

/// Класс [AudioHandler] представляет интерфейс для проигрывания плейлиста
abstract class AudioPlayerHandler implements AudioHandler {
  Stream<QueueState> get queueState;
  ValueStream<double> get volume;
  Future<void> setVolume(double volume);
  ValueStream<double> get speed;
}