import 'package:flutter/cupertino.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/ui/widgets/movie_card/mobile_movie_card.dart';
import 'package:flutter_tv/ui/widgets/movie_card/tv_movie_card.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

typedef MyBuilder = Widget Function({
  required Movie movie,
  required int index,
  required GestureTapCallback onTap,
});

MyBuilder getMovieCard() => MyPlatform.isTv ? getTvCard : getMobileCard;

Widget getTvCard({
  required Movie movie,
  required int index,
  required GestureTapCallback onTap,
}) =>
    TvMovieCard(
      movie: movie,
      index: index,
      onTap: onTap,
      key: ValueKey(movie.name),
    );

Widget getMobileCard({
  required Movie movie,
  required int index,
  required GestureTapCallback onTap,
}) =>
    MovieCard(
      movie: movie,
      index: index,
      onTap: onTap,
      key: ValueKey(movie.name),
    );
