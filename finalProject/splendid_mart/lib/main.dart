import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splendid_mart/common/widgets/bottom_bar.dart';
import 'package:splendid_mart/common/widgets/loader.dart';
import 'package:splendid_mart/constants/global_variables.dart';
import 'package:splendid_mart/features/admin/screens/admin_screen.dart';
import 'package:splendid_mart/features/auth/screens/auth_screen.dart';
import 'package:splendid_mart/features/auth/services/auth_service.dart';
import 'package:splendid_mart/providers/user_provider.dart';
import 'package:splendid_mart/router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthenticationHandler(),
    );
  }
}

class AuthenticationHandler extends StatelessWidget {
  const AuthenticationHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return FutureBuilder<void>(
      future: authService.getUserData(context),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loader while waiting for the future to complete
          return const Loader();
        } else if (snapshot.hasError) {
          // Handle any errors that occurred during the future execution
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final user = Provider.of<UserProvider>(context).user;
          return user.token.isNotEmpty
              ? user.type == 'user'
                  ? const BottomBar()
                  : const AdminScreen()
              : const AuthScreen();
        }
      },
    );
  }
}
