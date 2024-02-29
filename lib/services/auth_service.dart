import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_project/exceptions/auth_exception.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<User?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      await user.updateDisplayName(name);
      return user;
    } else {
      throw AuthException(
        message: 'Something went wrong while registering!',
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  String? getDisplayName() {
    return _auth.currentUser!.displayName;
  }
}
