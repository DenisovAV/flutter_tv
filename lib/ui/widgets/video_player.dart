import 'package:flutter/material.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print(widget.path);
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.path),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: MyPlatform.isTv || MediaQuery.of(context).orientation == Orientation.landscape
              ? double.infinity
              : MediaQuery.of(context).size.height / 3,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              VideoPlayer(_controller),
              VideoProgressIndicator(_controller, allowScrubbing: true),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
