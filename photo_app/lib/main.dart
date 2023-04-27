import 'package:flutter/material.dart';
import 'package:photo_app/screens/sign_up_screen.dart';

import 'screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  ErrorWidget.builder = (FlutterErrorDetails details) => Material(
        color: Colors.blue.shade200,
        child: Center(
          child: Text(
            details.exception.toString(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SignInScreen(),
    );
  }
}
