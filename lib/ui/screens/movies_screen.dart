import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/movies_bloc.dart';
import 'package:flutter_tv/business/user_bloc.dart';
import 'package:flutter_tv/ui/screens/add_screen.dart';
import 'package:flutter_tv/ui/screens/user_screen.dart';
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
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Movies',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (state is UserLoadedState && state.user.admin)
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddScreen();
                  },
                ),
              ),
              icon: Icon(Icons.add_circle),
            ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return UserScreen();
                },
              ),
            ),
            icon: Icon(Icons.account_circle),
          ),
        ],
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesBloc>(
          create: (_) => MoviesBloc()..add(MoviesInitializeEvent()),
        ),
      ],
      child: Scaffold(
        body: MyPlatform.isTv ? moviesScreen : SafeArea(child: moviesScreen),
      ),
    );
  }
}
