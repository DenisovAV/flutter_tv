import 'package:flutter_tv/services/auth_service.dart';
import 'package:flutter_tv/services/firebase_auth_service.dart';
import 'package:flutter_tv/services/firebase_movies_service.dart';
import 'package:flutter_tv/services/movies_service.dart';

MoviesService getMoviesService() {
  return FirebaseMoviesService();
}

AuthService getAuthService() {
  return FirebaseAuthService();
}
