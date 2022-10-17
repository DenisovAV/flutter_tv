import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/movies_bloc.dart';
import 'package:flutter_tv/ui/widgets/movie_details.dart';
import 'package:flutter_tv/ui/widgets/movie_grid.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildTitle() {
    return Container(
      child: const Align(
        alignment: Alignment(-0.9,0.0), //aligning the logo
        child: Text(  //change this to an image of the logo later
          'JOI',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.normal,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }

  Widget _mainMenu() {
    return Expanded(
      child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        if (state is MoviesLoadedState) {
          return MovieGrid(
            movies: state.movies,
            onTapMovie: (movie) => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MovieDetails(movie: movie);
            })),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomePage = Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildTitle(),
        _mainMenu(),
      ],
    );
    return Scaffold(
      body: MyPlatform.isTv ? HomePage : SafeArea(child: HomePage),
    );
  }
}
