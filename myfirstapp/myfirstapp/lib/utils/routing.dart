import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myfirstapp/sign_in.dart';
import 'package:myfirstapp/sign_up.dart';
import 'package:myfirstapp/screen1.dart';

class AppRoute {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const SignIn();
      },
    ),
    GoRoute(
      path: "/signup",
      builder: (BuildContext context, GoRouterState state) {
        return const SignUp();
      },
    ),
    GoRoute(
      path: "/screen1",
      builder: (BuildContext context, GoRouterState state) {
        return const Screen1();
      },
    ),
  ]);
}
