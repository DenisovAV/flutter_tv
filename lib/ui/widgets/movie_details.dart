import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';
import 'package:flutter_tv/ui/widgets/video_player.dart';

import '../focus/extensions.dart';
import '../focus/scale_widget.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({required this.movie, Key? key}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      const SizedBox(
        height: 10.0,
      ),
      Center(
        child: Text(
          movie.name,
          style: TextStyle(
            fontSize: MyPlatform.isTv ? 48.0 : 24.0,
            color: MyPlatform.isTv ? Colors.white : Colors.black,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
        child: Text(
          movie.meta,
          style: TextStyle(
            fontSize: MyPlatform.isTv ? 32.0 : 16.0,
            color: MyPlatform.isTv ? Colors.white : Colors.black,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Text(
          movie.synopsis,
          style: TextStyle(
            fontSize: MyPlatform.isTv ? 16.0 : 12.0,
            color: MyPlatform.isTv ? Colors.white : Colors.black,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Text(
          'Rating: ${movie.rating}',
          style: TextStyle(
            fontSize: MyPlatform.isTv ? 28.0 : 14.0,
            color: MyPlatform.isTv ? Colors.white : Colors.black,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
          child: Text(
            'Trailer',
            style: TextStyle(
              fontSize: MyPlatform.isTv ? 28.0 : 14.0,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PlayerPage(path: 'assets/videos/${movie.id}.mp4');
              },
            ),
          ),
        ),
      ),
    ];

    return Material(
      child: MyPlatform.isTv ? getTvDetails(widgets) : getDetails(widgets),
    );
  }

  Widget getDetails(List<Widget> widgets) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: movie.name,
                child: Image.asset(
                  'assets/images/${movie.id}.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(widgets),
          ),
        ],
      ),
    );
  }

  Widget getTvDetails(List<Widget> widgets) {
    final details = Scaffold(
      body: Stack(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) => Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Hero(
                tag: movie.name,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/${movie.id}.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: widgets),
        ],
      ),
    );

    return isScaled ? ScaleWidget(child: details) : details;
  }
}
