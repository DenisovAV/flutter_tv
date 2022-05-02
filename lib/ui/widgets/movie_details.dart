import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/focus/scale_widget.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({required this.movie, Key? key}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final width = WidgetsBinding.instance!.window.physicalSize.width;
    final pixelRatio = WidgetsBinding.instance!.window.devicePixelRatio;

    return Material(
      child: MyPlatform.isTv
          ? ScaleWidget(
              ratio: width / (kTvSize.width * pixelRatio),
              child: getDetails(),
            )
          : getDetails(),
    );
  }

  Widget getDetails() {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: MyPlatform.isTv ? 500.0 : 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: movie.name,
                child: Image.asset(
                  'assets/images/${movie.image}.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  movie.name,
                  style: TextStyle(
                    fontSize: MyPlatform.isTv ? 48.0 : 24.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
                child: Text(
                  movie.meta,
                  style: TextStyle(
                    fontSize: MyPlatform.isTv ? 32.0 : 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Text(
                  movie.synopsis,
                  style: TextStyle(
                    fontSize: MyPlatform.isTv ? 18.0 : 12.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Text(
                  'Rating: ${movie.rating}',
                  style: TextStyle(
                    fontSize: MyPlatform.isTv ? 28.0 :14.0,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
