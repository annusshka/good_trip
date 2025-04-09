import 'package:audio_service/audio_service.dart';

class QueueState2 {
  static const QueueState2 empty = QueueState2([], 0);

  /// Список из аудиозаписей
  final List<MediaItem> queue;

  /// Актуальная аудиозапись - индекс из списка [queue]
  final int? queueIndex;

  const QueueState2(
    this.queue,
    this.queueIndex,
  );

  /// Предыдущая запись доступна, если
  /// Аудизаписей больше одной и актуальная аудиозапись не первая
  bool get hasPrevious => queue.length > 1 && (queueIndex ?? 0) > 0;

  /// Следующая запись доступна, если
  /// Аудизаписей больше одной и актуальная аудиозапись не последняя
  bool get hasNext => queue.length > 1 && (queueIndex ?? 0) + 1 < queue.length;

  List<int> get indices => List.generate(queue.length, (i) => i);
}
