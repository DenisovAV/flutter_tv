import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/widgets/movie_card/mobile_movie_card.dart';
import 'package:custom_shared_preferences_ios/custom_shared_preferences_ios.dart';

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
  static const _hoverDuration = Duration(milliseconds: 300);

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
          _incrementCounter();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: AnimatedScale(
        scale: _isFocused ? 1.1 : 1.0,
        duration: _hoverDuration,
        child: AnimatedPhysicalModel(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black,
          shape: BoxShape.rectangle,
          elevation: _isFocused ? 25 : 10,
          shadowColor: Colors.black,
          duration: _hoverDuration,
          curve: Curves.fastOutSlowIn,
          child: MovieCard(
            movie: widget.movie,
            index: widget.index,
          ),
        ),
      ),
    );
  }

  Future<void> _incrementCounter() async {
    final CustomSharedPreferencesIOS prefs = await CustomSharedPreferencesIOS.getInstance();
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('ALDE $counter');
    prefs.setInt('counter', counter);
  }
}
