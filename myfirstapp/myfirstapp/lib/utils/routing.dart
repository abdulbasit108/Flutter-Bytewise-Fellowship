import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myfirstapp/sign_in.dart';
import 'package:myfirstapp/sign_up.dart';

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
  ]);
}
