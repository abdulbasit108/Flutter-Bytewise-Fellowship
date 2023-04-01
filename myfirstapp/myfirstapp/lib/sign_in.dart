import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myfirstapp/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koderz Kombat'),
        backgroundColor: const Color.fromARGB(255, 40, 100, 42),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 105,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                foregroundImage: AssetImage("assets/images/Logo blue bg.png"),
                radius: 100,
              ),
            ),
            //const Spacer(),
            const TextField(
              decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            //const Spacer(),
            TextButton(
              onPressed: () {
                context.go("/screen1");
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 40, 100, 42),
                  fixedSize: const Size(100, 10)),
              child: const Text(
                'Sign In',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const SignUp()),
                    // );
                    context.go("/signup");
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
