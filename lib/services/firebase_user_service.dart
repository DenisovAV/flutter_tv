import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tv/domain/user.dart';
import 'package:flutter_tv/services/user_service.dart';

class FirebaseUserService implements UserService {
  @override
  Stream<MoviesUser?> getUser() => FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots()
          .map((doc) {
        final data = doc.data();
        return data != null ? MoviesUser.fromJson(data) : null;
      });
}
