import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';
//import 'package:to_do_app/pages/home_page.dart';
import 'package:to_do_app/pages/sign_up_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.black,
      body: AnimatedSplashScreen(
        // centered: false,5
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.black,
        animationDuration: const Duration(milliseconds: 1500),
        splashIconSize: _height,
        splash: 'assets/splash.png',
        nextScreen: SignUpScreen(),
        // nextRoute: '/home_screen',
        // nextScreen: MainScreen(),
      ),
    );
  }
}
