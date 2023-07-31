import 'package:flutter/material.dart';
import 'package:twitch_clone_tutorial/utils/colors.dart';
import 'package:twitch_clone_tutorial/widgets/chat.dart';
import 'package:video_player/video_player.dart';

// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  String result;
  VideoApp(this.result);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.result.toString())
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  @override
  Widget build(BuildContext context) {
    print(widget.result);
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Column(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            VideoProgressIndicator(_controller, allowScrubbing: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Playback Speed: '),
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<double>(
                    initialValue: _controller.value.playbackSpeed,
                    tooltip: 'Playback speed',
                    onSelected: (double speed) {
                      _controller.setPlaybackSpeed(speed);
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuItem<double>>[
                        for (final double speed in _examplePlaybackRates)
                          PopupMenuItem<double>(
                            value: speed,
                            child: Text('${speed}x'),
                          )
                      ];
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        // Using less vertical padding as the text is also longer
                        // horizontally, so it feels like it would need more spacing
                        // horizontally (matching the aspect ratio of the video).
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Text('${_controller.value.playbackSpeed}x'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('The video link is: ${widget.result}'),
            )
            // Expanded(
            //   child: Chat(
            //     channelId: widget.channelId,
            //   ),
            // ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: buttonColor,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

// class BumbleBeeRemoteVideo extends StatefulWidget {
//   @override
//   BumbleBeeRemoteVideoState createState() => BumbleBeeRemoteVideoState();
// }

// class BumbleBeeRemoteVideoState extends State<BumbleBeeRemoteVideo> {
//   late VideoPlayerController _controller;

//   Future<ClosedCaptionFile> _loadCaptions() async {
//     final String fileContents = await DefaultAssetBundle.of(context)
//         .loadString('assets/bumble_bee_captions.vtt');
//     return WebVTTCaptionFile(
//         fileContents); // For vtt files, use WebVTTCaptionFile
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       closedCaptionFile: _loadCaptions(),
//       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//     );

//     _controller.addListener(() {
//       setState(() {});
//     });
//     _controller.setLooping(true);
//     _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           Container(padding: const EdgeInsets.only(top: 20.0)),
//           const Text('With remote mp4'),
//           Container(
//             padding: const EdgeInsets.all(20),
//             child: AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: <Widget>[
//                   VideoPlayer(_controller),
//                   ClosedCaption(text: _controller.value.caption.text),
//                   _ControlsOverlay(controller: _controller),
//                   VideoProgressIndicator(_controller, allowScrubbing: true),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ControlsOverlay extends StatelessWidget {
//   const _ControlsOverlay({Key? key, required this.controller})
//       : super(key: key);

//   static const List<Duration> _exampleCaptionOffsets = <Duration>[
//     Duration(seconds: -10),
//     Duration(seconds: -3),
//     Duration(seconds: -1, milliseconds: -500),
//     Duration(milliseconds: -250),
//     Duration.zero,
//     Duration(milliseconds: 250),
//     Duration(seconds: 1, milliseconds: 500),
//     Duration(seconds: 3),
//     Duration(seconds: 10),
//   ];
//   static const List<double> _examplePlaybackRates = <double>[
//     0.25,
//     0.5,
//     1.0,
//     1.5,
//     2.0,
//     3.0,
//     5.0,
//     10.0,
//   ];

//   final VideoPlayerController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 50),
//           reverseDuration: const Duration(milliseconds: 200),
//           child: controller.value.isPlaying
//               ? const SizedBox.shrink()
//               : Container(
//                   color: Colors.black26,
//                   child: const Center(
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 100.0,
//                       semanticLabel: 'Play',
//                     ),
//                   ),
//                 ),
//         ),
//         GestureDetector(
//           onTap: () {
//             controller.value.isPlaying ? controller.pause() : controller.play();
//           },
//         ),
//         Align(
//           alignment: Alignment.topLeft,
//           child: PopupMenuButton<Duration>(
//             initialValue: controller.value.captionOffset,
//             tooltip: 'Caption Offset',
//             onSelected: (Duration delay) {
//               controller.setCaptionOffset(delay);
//             },
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuItem<Duration>>[
//                 for (final Duration offsetDuration in _exampleCaptionOffsets)
//                   PopupMenuItem<Duration>(
//                     value: offsetDuration,
//                     child: Text('${offsetDuration.inMilliseconds}ms'),
//                   )
//               ];
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 // Using less vertical padding as the text is also longer
//                 // horizontally, so it feels like it would need more spacing
//                 // horizontally (matching the aspect ratio of the video).
//                 vertical: 12,
//                 horizontal: 16,
//               ),
//               child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: PopupMenuButton<double>(
//             initialValue: controller.value.playbackSpeed,
//             tooltip: 'Playback speed',
//             onSelected: (double speed) {
//               controller.setPlaybackSpeed(speed);
//             },
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuItem<double>>[
//                 for (final double speed in _examplePlaybackRates)
//                   PopupMenuItem<double>(
//                     value: speed,
//                     child: Text('${speed}x'),
//                   )
//               ];
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 // Using less vertical padding as the text is also longer
//                 // horizontally, so it feels like it would need more spacing
//                 // horizontally (matching the aspect ratio of the video).
//                 vertical: 12,
//                 horizontal: 16,
//               ),
//               child: Text('${controller.value.playbackSpeed}x'),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
