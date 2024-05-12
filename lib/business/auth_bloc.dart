import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/services/services.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState());

  StreamSubscription<bool>? _authSubscription;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event) {
      case (AuthInitializeEvent _):
        _authSubscription = getAuthService().getAuthStatus().listen(
          (status) {
            add(AuthStatusChangedEvent(status: status));
          },
        );
      case (AuthStatusChangedEvent event):
        yield AuthStatusChangedState(status: event.status);
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}

abstract class AuthEvent {}

class AuthInitializeEvent extends AuthEvent {}

class AuthStatusChangedEvent extends AuthEvent {
  final bool status;

  AuthStatusChangedEvent({required this.status});
}

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthStatusChangedState extends AuthState {
  final bool status;

  AuthStatusChangedState({required this.status});
}
