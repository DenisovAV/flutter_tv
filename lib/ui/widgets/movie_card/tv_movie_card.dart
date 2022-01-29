import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/widgets/movie_card/mobile_movie_card.dart';

class TvMovieCard extends StatefulWidget {
  final int index;
  final GestureTapCallback? onTap;
  final Movie movie;

  const TvMovieCard({
    required this.movie,
    required this.index,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _TvMovieCardState createState() => _TvMovieCardState();
}

class _TvMovieCardState extends State<TvMovieCard> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onFocusChange: (value) => setState(() {
        _isFocused = value;
      }),
      onKey: (_, event) {
        if (widget.onTap != null && event.hasSubmitIntent) {
          widget.onTap!();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: _isFocused ? Colors.teal : Colors.transparent,
            width: 10,
          ),
        ),
        child: MovieCard(
          movie: widget.movie,
          index: widget.index,
        ),
      ),
    );
  }
}
