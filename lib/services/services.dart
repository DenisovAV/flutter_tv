import 'package:flutter_tv/services/auth_service.dart';
import 'package:flutter_tv/services/firebase_auth_service.dart';
import 'package:flutter_tv/services/firebase_gemini_service.dart';
import 'package:flutter_tv/services/firebase_movies_service.dart';
import 'package:flutter_tv/services/firebase_storage_service.dart'
    if (dart.library.html) 'package:flutter_tv/services/firebase_storage_service_web.dart';
import 'package:flutter_tv/services/firebase_user_service.dart';
import 'package:flutter_tv/services/gemini_service.dart';
import 'package:flutter_tv/services/movies_service.dart';
import 'package:flutter_tv/services/storage_service.dart';
import 'package:flutter_tv/services/user_service.dart';

MoviesService getMoviesService() {
  return FirebaseMoviesService();
}

AuthService getAuthService() {
  return FirebaseAuthService();
}

UserService getUserService() {
  return FirebaseUserService();
}

StorageService getStorageService() {
  return FirebaseStorageService();
}

GeminiService getGeminiService() {
  return FirebaseGeminiService() ;
}
