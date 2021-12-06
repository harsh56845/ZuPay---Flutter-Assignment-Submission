
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp_zu/pages/homepage.dart';
import 'package:moviesapp_zu/pages/login.dart';

import 'package:provider/provider.dart';



class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    

    if (firebaseUser != null) {
      return  const HomePage();
      
    }

    return Login();
  }
}
