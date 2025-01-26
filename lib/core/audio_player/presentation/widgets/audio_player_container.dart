// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:good_trip/core/audio_player/presentation/bloc/audio_player.dart';
// import 'package:just_audio/just_audio.dart';
//
// class AudioPlayerContainer extends StatelessWidget {
//   const AudioPlayerContainer({
//     super.key,
//     required this.url,
//     this.activeColor = Colors.white,
//     this.timerTextStyle,
//     required this.sliderThemeData,
//   });
//
//   final String url;
//   final Color activeColor;
//   final TextStyle? timerTextStyle;
//   final SliderThemeData sliderThemeData;
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<AudioPlayerCubit>();
//     cubit.loadExcursion(url: url);
//
//     return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
//       builder: (context, state) {
//         if (state is AudioPlayerIsLoading) {
//           return const CircularProgressIndicator();
//         } else if (state is AudioPlayerLoadSuccess) {
//           return Row(
//             children: [
//               StreamBuilder<PlaybackState>(
//                 stream: cubit.audioPlayerHandler.playbackState,
//                 builder: (context, snapshot) {
//                   final playerState = snapshot.data;
//
//                   if (playerState == null) {
//                     return const SizedBox.shrink();
//                   }
//
//                   final processingState = playerState.processingState;
//
//                   final playing = playerState.playing;
//                   if (processingState == AudioProcessingState.loading ||
//                       processingState == AudioProcessingState.buffering) {
//                     return Container(
//                       margin: const EdgeInsets.all(8.0),
//                       width: 24,
//                       height: 24,
//                       child: CircularProgressIndicator(color: activeColor),
//                     );
//                   } else if (playing != true) {
//                     return GestureDetector(
//                       onTap: cubit.playAudio,
//                       child: Icon(
//                         Icons.play_arrow,
//                         color: activeColor,
//                         size: 24,
//                       ),
//                     );
//                   } else if (processingState != AudioProcessingState.completed) {
//                     return GestureDetector(
//                       onTap: cubit.stopAudio,
//                       child: Icon(
//                         Icons.pause,
//                         color: activeColor,
//                         size: 24,
//                       ),
//                     );
//                   } else {
//                     return GestureDetector(
//                       onTap: cubit.replay,
//                       child: Icon(
//                         Icons.replay,
//                         color: activeColor,
//                         size: 24,
//                       ),
//                     );
//                   }
//                 },
//               ),
//               // GestureDetector(
//               //   onTap: () {
//               //     cubit.playOrPauseSong();
//               //   },
//               //   child: Container(
//               //     height: 40,
//               //     width: 40,
//               //     decoration: const BoxDecoration(
//               //       shape: BoxShape.circle,
//               //       color: Colors.red,
//               //     ),
//               //     child: Icon(
//               //       cubit.audioPlayer.playing ? Icons.pause : Icons.play_arrow,
//               //     ),
//               //   ),
//               // ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Expanded(
//                 child: Stack(
//                   children: [
//                     SliderTheme(
//                       data: sliderThemeData,
//                       child: Slider(
//                         value: cubit.audioPosition.inMilliseconds.toDouble(),
//                         min: 0.0,
//                         max: cubit.audioDuration.inMilliseconds.toDouble(),
//                         onChanged: (value) {
//                           final newDuration =
//                               Duration(milliseconds: value.toInt());
//                           cubit.updatePosition(newDuration);
//                         },
//                       ),
//                     ),
//                     Positioned(
//                       left: 16.0,
//                       bottom: 0.0,
//                       child: Text(
//                         formatDuration(
//                           cubit.audioPosition,
//                         ),
//                         style: timerTextStyle,
//                       ),
//                     ),
//                     Positioned(
//                       right: 16.0,
//                       bottom: 0.0,
//                       child: Text(
//                         formatDuration(
//                           cubit.audioDuration,
//                         ),
//                         style: timerTextStyle,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
//
//   String formatDuration(Duration duration) {
//     final minutes = duration.inMinutes.remainder(60);
//     final seconds = duration.inSeconds.remainder(60);
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }
// }
