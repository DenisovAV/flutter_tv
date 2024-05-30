import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/services/services.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  GeminiBloc() : super(GeminiInitialState());

  StreamSubscription<String?>? _geminiSubscription;

  @override
  Stream<GeminiState> mapEventToState(GeminiEvent event) async* {
    switch (event) {
      case (GeminiRefreshEvent _):
        yield GeminiInitialState();
      case (GeminiRequestInfoEvent request):
        yield GeminiRequestInfoState();
        _geminiSubscription = getGeminiService()
            .getDescription('Tell me about ${request.movie.meta} ${request.movie.name}, about director, actors, and story itself')
            .listen(
          (token) {
            add(_GeminiProvideInfoEvent(token: token));
          },
        );
      case (_GeminiProvideInfoEvent event):
        print('EVENT ${event.token}');
        await Future.delayed(Duration(milliseconds: 200));
        yield GeminiProvidedInfoState(token: event.token);
    }
  }

  @override
  Future<void> close() {
    _geminiSubscription?.cancel();
    return super.close();
  }
}

abstract class GeminiState {}

class GeminiInitialState extends GeminiState {}

class GeminiRequestInfoState extends GeminiState {}

class GeminiProvidedInfoState extends GeminiState {
  final String? token;

  GeminiProvidedInfoState({required this.token});
}

abstract class GeminiEvent {}

class GeminiRefreshEvent extends GeminiEvent {}

class GeminiRequestInfoEvent extends GeminiEvent {
  final Movie movie;

  GeminiRequestInfoEvent({required this.movie});
}

class _GeminiProvideInfoEvent extends GeminiEvent {
  final String? token;

  _GeminiProvideInfoEvent({required this.token});
}
