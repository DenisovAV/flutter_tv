import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/domain/user.dart';
import 'package:flutter_tv/services/services.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState());

  StreamSubscription<MoviesUser?>? _userSubscription;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    switch (event) {
      case (UserInitializeEvent _):
        _userSubscription = getUserService().getUser().listen(
          (user) {
            if (user != null) {
              add(UserRefreshEvent(user: user));
            }
          },
        );
      case (UserRefreshEvent event):
        yield UserLoadedState(user: event.user);
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

abstract class UserEvent {}

class UserInitializeEvent extends UserEvent {}

class UserRefreshEvent extends UserEvent {
  final MoviesUser user;

  UserRefreshEvent({required this.user});
}

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadedState extends UserState {
  final MoviesUser user;

  UserLoadedState({required this.user});
}
