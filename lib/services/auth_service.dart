import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> createUserWithEmailAndPassword({required String email, required String password}){
    return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}