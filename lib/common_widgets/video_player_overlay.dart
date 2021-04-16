import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/video_player.dart';
import 'package:payment_gateway/navigator/navigator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerOverlay extends StatefulWidget {
  final String id;

  VideoPlayerOverlay({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _VideoPlayerOverlayState createState() => _VideoPlayerOverlayState();
}

class _VideoPlayerOverlayState extends State<VideoPlayerOverlay> {
  YoutubePlayerController controller;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller ??= YoutubePlayerController(
      initialVideoId: widget.id ?? 'h9Am4CYaLng',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    return Container(
      child: GestureDetector(
        onTap: () {
          NavigationService.instance.push(
            context,
            VideoPlayer.route,
            arguments: widget.id,
          );
        },
        child: AbsorbPointer(
          absorbing: true,
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
      ),
    );
  }
}
