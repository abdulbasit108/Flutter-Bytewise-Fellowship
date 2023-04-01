import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myfirstapp/sign_in.dart';
import 'package:go_router/go_router.dart';
import 'package:myfirstapp/utils/routing.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          textTheme:
              const TextTheme(titleMedium: TextStyle(color: Colors.white))),
      routerDelegate: AppRoute.router.routerDelegate,
      routeInformationProvider: AppRoute.router.routeInformationProvider,
      routeInformationParser: AppRoute.router.routeInformationParser,
      //home: const SignIn(),
    ),
  );
}
