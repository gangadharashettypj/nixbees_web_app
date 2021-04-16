import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Creates list of video players
class VideoPlayer extends StatefulWidget {
  static const String route = '/videoPlayer';
  final String id;

  VideoPlayer({
    Key key,
    this.id,
  }) : super(key: key);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  void dispose() {
    if(controller.value.isFullScreen){
      controller.toggleFullScreenMode();
    }
    super.dispose();
  }

  YoutubePlayerController controller;
  @override
  Widget build(BuildContext context) {
    controller ??= YoutubePlayerController(
      initialVideoId: widget.id ?? 'h9Am4CYaLng',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        controlsVisibleAtStart: true,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
          key: ObjectKey(controller),
          controller: controller,
          actionsPadding: const EdgeInsets.only(left: 16.0),
          bottomActions: [
            CurrentPosition(),
            const SizedBox(width: 10.0),
            ProgressBar(isExpanded: true),
            const SizedBox(width: 10.0),
            RemainingDuration(),
            FullScreenButton(),
          ],
        ),
      ),
    );
  }
}
