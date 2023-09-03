import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/services/movies_service.dart';

class FirebaseMoviesService implements MoviesService {
  @override
  Stream<List<Movie>> getMovies() => FirebaseFirestore.instance
      .collection('movies')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Movie.fromJson(doc.data())).toList());
}
