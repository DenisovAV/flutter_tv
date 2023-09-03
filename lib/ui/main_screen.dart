import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/auth_bloc.dart';
import 'package:flutter_tv/ui/screens/login_screen.dart';
import 'package:flutter_tv/ui/screens/movies_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      switch (state) {
        case (AuthInitialState _):
          return const Center(
            child: CircularProgressIndicator(),
          );
        case (AuthStatusChangedState state):
          if (state.status) {
            return MoviesScreen();
          } else {
            return LoginScreen();
          }
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
