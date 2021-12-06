import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp_zu/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import 'auth/authenticate_page.dart';

import 'providers/auth_view_model.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<MoviesData>(
    create: (_) => MoviesData(),
    child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
       providers: [
        ChangeNotifierProvider<MoviesData>(
          create: (context) => MoviesData(),),
        
        Provider<AuthViewModel>(
          create: (_) => AuthViewModel(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) => context.read<AuthViewModel>().authState,
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Authenticate(),
      ),
    );
  }
}
