import 'package:custom_native_video_player_ios/native_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  NativeVideoPlayerView? player;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MyPlatform.isTv || MediaQuery.of(context).orientation == Orientation.landscape
              ? double.infinity
              : MediaQuery.of(context).size.height / 3,
          child: NativeVideoPlayerView(
            onViewReady: (controller) async {
              final videoSource = await VideoSource.init(
                type: VideoSourceType.asset,
                path: widget.path,
              );
              await controller.loadVideoSource(videoSource);
              await controller.play();
            },
          ),
        ),
      ),
    );
  }
}
