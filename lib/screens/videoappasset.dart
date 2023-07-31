import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:twitch_clone_tutorial/utils/colors.dart';
import 'package:twitch_clone_tutorial/widgets/chat.dart';
import 'package:video_player/video_player.dart';

// Stateful widget to fetch and then display video content.
class VideoAppAsset extends StatefulWidget {
  PlatformFile? result;
  VideoAppAsset(this.result);

  @override
  _VideoAppAssetState createState() => _VideoAppAssetState();
}

class _VideoAppAssetState extends State<VideoAppAsset> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.result!.name)
      ..initialize().then((value) {
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
