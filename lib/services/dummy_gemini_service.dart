import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/services/gemini_service.dart';

class DummyGeminiService implements GeminiService {

  @override
  Stream<String> getDescription(String prompt) async* {
    final text = 'This is a movie very interesting, lets try to discuss it, his is a movie very interesting, lets try to discuss it, his is a movie very interesting, lets try to discuss it,';
    for (int i = 0; i < text.length; i++) {
      yield text[i];
      await Future.delayed(Duration(milliseconds: 50));
    }
  }
}
