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
            expandedHeight: 500.0,
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
                  style: const TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
                child: Text(
                  movie.meta,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Text(
                  movie.synopsis,
                  style: const TextStyle(
                    fontSize: 12.0,
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
