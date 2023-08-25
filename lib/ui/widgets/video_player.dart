import 'package:custom_native_video_player_ios/native_video_player.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
          child: NativeVideoPlayerView(
            onViewReady: (controller) async {
              final videoSource = await VideoSource.init(
                type: VideoSourceType.asset,
                path: 'assets/Butterfly-209.mp4',
              );
              await controller.loadVideoSource(videoSource);
              await controller.play();
            },
          ),), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


