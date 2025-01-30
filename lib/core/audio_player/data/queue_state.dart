import 'package:audio_service/audio_service.dart';

class QueueState {
  static const QueueState empty =
      QueueState([], 0, [], AudioServiceRepeatMode.none);

  /// Список из аудиозаписей
  final List<MediaItem> queue;

  /// Актуальная аудиозапись - индекс из списка [queue]
  final int? queueIndex;

  /// Список порядка аудиозаписей - перетасованные индексы списка [queue]
  final List<int>? shuffleIndices;

  /// Настройка повтора аудиозаписи
  final AudioServiceRepeatMode repeatMode;

  const QueueState(
    this.queue,
    this.queueIndex,
    this.shuffleIndices,
    this.repeatMode,
  );

  /// Предыдущая запись доступна, если
  /// Настройка повтора - повтор есть или актуальная аудиозапись не первая
  bool get hasPrevious =>
      repeatMode != AudioServiceRepeatMode.none || (queueIndex ?? 0) > 0;

  /// Следующая запись доступна, если
  /// Настройка повтора - повтор есть или актуальная аудиозапись не последняя
  bool get hasNext =>
      repeatMode != AudioServiceRepeatMode.none ||
      (queueIndex ?? 0) + 1 < queue.length;

  /// Если есть перестановка, то актуальный порядок [shuffleIndices]
  List<int> get indices =>
      shuffleIndices ?? List.generate(queue.length, (i) => i);
}
