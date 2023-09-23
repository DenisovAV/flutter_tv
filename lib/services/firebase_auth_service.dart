import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tv/services/auth_service.dart';

class FirebaseAuthService implements AuthService {
  @override
  Stream<bool> getAuthStatus() =>
      FirebaseAuth.instance.authStateChanges().map((user) => true);
}
