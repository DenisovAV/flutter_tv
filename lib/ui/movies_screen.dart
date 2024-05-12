import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/movies_bloc.dart';
import 'package:flutter_tv/ui/widgets/movie_details.dart';
import 'package:flutter_tv/ui/widgets/movie_grid.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  Widget _buildTitle() {
    return const Center(
      child: Text(
        'Movies',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMoviesGrid() {
    return Expanded(
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoadedState) {
            return MovieGrid(
              movies: state.movies,
              onTapMovie: (movie) => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MovieDetails(movie: movie);
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final moviesScreen = Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildTitle(),
        _buildMoviesGrid(),
      ],
    );
    return Scaffold(
      body: MyPlatform.isTv ? moviesScreen : SafeArea(child: moviesScreen),
    );
  }
}
