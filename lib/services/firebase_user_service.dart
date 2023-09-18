import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tv/domain/user.dart';
import 'package:flutter_tv/services/user_service.dart';

class FirebaseUserService implements UserService {
  @override
  Future<MoviesUser?> getUser() async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance.collection('users').doc(id).get();
    return document.exists ? MoviesUser.fromJson(document.data()!) : null;
  }
}
