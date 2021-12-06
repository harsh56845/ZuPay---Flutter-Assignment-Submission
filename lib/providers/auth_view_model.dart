// ignore_for_file: avoid_print, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp_zu/pages/homepage.dart';
import 'package:moviesapp_zu/models/user_model.dart';
import 'package:moviesapp_zu/pages/login.dart';
import 'package:moviesapp_zu/services/auth_service.dart';
import 'package:moviesapp_zu/services/firestore_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  final FirestoreService _firestoreService = FirestoreService();
  //FirebaseAuth instance
  AuthViewModel(this.firebaseAuth);
  //Constuctor to initalize the FirebaseAuth instance

  //Using Stream to listen to Authentication State
  Stream<User?> get authState => firebaseAuth.idTokenChanges();
  final AuthService _authService = AuthService();

  createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context,
      required String name}) async {
    try {
      
      UserCredential userCredential = await _authService
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        UserModel userModel = UserModel(
            email: email,
            name: name,
            timestamp: DateTime.now().microsecondsSinceEpoch,
            uid: userCredential.user!.uid);
        _firestoreService
            .createNewUser(userModel)
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        sendVerificationLink(userCredential: userCredential, context: context)
            .then((_) {
              
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Login()));
        });
      } else {

        showSnackBar(content: 'User is already exist', context: context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Login()));
      }
    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        showSnackBar(
            content: 'The password provided is too weak.', context: context);
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
            content: 'The account already exists for that email.',
            context: context);
      }
    } on Exception catch (e) {
      
      print(e.toString());
    }
  }

  signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {

      UserCredential userCredential = await _authService
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) =>  const HomePage(
                  
                )));
      } else {
        
        showSnackBar(
            content: 'User is not verifired, send verification link again',
            context: context,
            onPressedCallback: () {
              sendVerificationLink(
                  context: context, userCredential: userCredential);
            });
        //step 1 open modal and ask user to send verification link
      }
    } on FirebaseAuthException catch (e) {
      
      if (e.code == 'user-not-found') {
        showSnackBar(
            content: 'No user found for that email.', context: context);
      } else if (e.code == 'wrong-password') {
        showSnackBar(
            content: 'Wrong password provided for that user.',
            context: context);
      }else{
        showSnackBar(
            content: '${e.message}',
            context: context);
      }

    } on Exception {
      
    }
  }

  showSnackBar(
      {required String content,
      required BuildContext context,
      VoidCallback? onPressedCallback}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      action: onPressedCallback != null
          ? SnackBarAction(
              label: "Ok, send",
              onPressed: onPressedCallback,
            )
          : null,
    ));
  }

  Future sendVerificationLink(
      {required UserCredential userCredential,
      required BuildContext context}) async {
    return await userCredential.user!.sendEmailVerification().then((value) {
      showSnackBar(
          content: 'Email Verification send successfully', context: context);
    });
  }

  signOutUser(BuildContext context) async {
    await firebaseAuth.signOut().then((_) => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Login()))
        });
  }
}
