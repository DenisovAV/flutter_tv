import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/domain/user.dart';
import 'package:flutter_tv/services/services.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    switch (event) {
      case (UserRefresheEvent _):
        final user = await getUserService().getUser();
        if (user != null) {
          yield UserLoadedState(user: user);
        }
    }
  }
}

abstract class UserEvent {}

class UserInitializeEvent extends UserEvent {}

class UserRefresheEvent extends UserEvent {}

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadedState extends UserState {
  final MoviesUser user;

  UserLoadedState({required this.user});
}
