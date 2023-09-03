import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier  {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (error) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
