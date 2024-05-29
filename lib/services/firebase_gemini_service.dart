import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter_tv/services/gemini_service.dart';

class FirebaseGeminiService implements GeminiService {
  final model = FirebaseVertexAI.instance.generativeModel(
    model: 'gemini-1.5-pro-preview-0409',
  );

  final config = GenerationConfig(
    maxOutputTokens: 1024,
    temperature: 1,

  );

  @override
  Stream<String?> getDescription(String prompt) =>
      model.generateContentStream([Content.text(prompt)]).map((response) => response.text);
}
