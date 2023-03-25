import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              radius: 50,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                foregroundImage: AssetImage("assets/images/Logo blue bg.png"),
                radius: 45,
              ),
            ),
            //const Spacer(),
            const TextField(
              decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            const TextField(
              decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            const TextField(
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
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
              onPressed: () {},
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 40, 100, 42),
                  fixedSize: const Size(100, 10)),
              child: const Text(
                'Sign Up',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    context.go("/");
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Sign In'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.help),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
