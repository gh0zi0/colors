import 'package:colors/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); 
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
