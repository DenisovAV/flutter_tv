import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.movie,
    required this.index,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final int index;
  final GestureTapCallback? onTap;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Focus(
          child: InkWell(
            onTap: onTap,
            child: Hero(
              tag: movie.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/${movie.image}.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
