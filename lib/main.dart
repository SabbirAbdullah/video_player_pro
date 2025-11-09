import 'package:flutter/material.dart';
import 'package:untitled1/presentation/bloc/vidoe_bloc.dart';
import 'package:untitled1/presentation/screens/vidoe_folder.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/repositories/video_repository.dart';
import 'domain/repositories/video_repository_impl.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final VideoRepository videoRepository = VideoRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<VideoRepository>(
      create: (_) => videoRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<VideoBloc>(
            create: (context) => VideoBloc(repository: videoRepository),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Video Player App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: FolderListScreen(),
        ),
      ),
    );
  }
}


// class FullScreenVideoPlayer extends StatefulWidget {
//   final String assetPath;
//
//   const FullScreenVideoPlayer({Key? key, required this.assetPath}) : super(key: key);
//
//   @override
//   _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
// }
//
// class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
//   late VideoPlayerController _controller;
//   bool _showControls = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Force landscape orientation
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//
//     _controller = VideoPlayerController.asset(widget.assetPath)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//
//     // Restore portrait
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//
//     super.dispose();
//   }
//
//   void _seekForward() {
//     final newPosition = _controller.value.position + const Duration(seconds: 10);
//     _controller.seekTo(newPosition > _controller.value.duration ? _controller.value.duration : newPosition);
//   }
//
//   void _seekBackward() {
//     final newPosition = _controller.value.position - const Duration(seconds: 10);
//     _controller.seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
//   }
//
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${twoDigits(duration.inHours)}:$minutes:$seconds";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         onTap: () {
//           setState(() {
//             _showControls = !_showControls;
//           });
//         },
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             Center(
//               child: _controller.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//                   : const CircularProgressIndicator(),
//             ),
//             if (_showControls && _controller.value.isInitialized)
//               Container(
//                 color: Colors.black54,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     VideoProgressIndicator(
//                       _controller,
//                       allowScrubbing: true,
//                       colors: VideoProgressColors(
//                         playedColor: Colors.red,
//                         bufferedColor: Colors.grey,
//                         backgroundColor: Colors.white54,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           onPressed: _seekBackward,
//                           icon: const Icon(Icons.replay_10, color: Colors.white, size: 30),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _controller.value.isPlaying ? _controller.pause() : _controller.play();
//                             });
//                           },
//                           icon: Icon(
//                             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: _seekForward,
//                           icon: const Icon(Icons.forward_10, color: Colors.white, size: 30),
//                         ),
//                         Text(
//                           "${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}",
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
