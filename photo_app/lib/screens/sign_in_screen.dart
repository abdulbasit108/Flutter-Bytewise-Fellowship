import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_app/main.dart';
import 'package:photo_app/screens/photo_feed_screen.dart';
import 'package:photo_app/screens/sign_up_screen.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

final GlobalKey<SlideActionState> slideActionKey =
    GlobalKey<SlideActionState>();

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FeedScreen()));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => MainScreen()));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      slideActionKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    slideActionKey.currentState?.reset();

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(145, 131, 222, 1),
            Color.fromRGBO(160, 148, 227, 1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: SizedBox(
                    width: double.infinity,
                    child: Column(children: [
                      SizedBox(
                        height: topPadding,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AnimatedImage(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Hi There!',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 330,
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: SlideAction(
                          key: slideActionKey,
                          elevation: 0,
                          borderRadius: 30,
                          outerColor: Color.fromRGBO(120, 37, 139, 1),
                          sliderButtonIcon: Icon(Icons.lock_open),
                          text: 'Slide to Login',
                          textStyle: TextStyle(fontSize: 18),
                          onSubmit: () {
                            if (_formkey.currentState!.validate()) {
                              login();
                            } else {
                              slideActionKey.currentState?.reset();
                            }
                          },
                        ),
                      ),
                      // Container(
                      //   height: 55,
                      //   width: 330,
                      //   decoration: BoxDecoration(
                      //       color: Color.fromRGBO(120, 37, 139, 1),
                      //       borderRadius: BorderRadius.circular(30)),
                      //   child: TextButton(
                      //       onPressed: () {
                      // if (_formkey.currentState!.validate()) {
                      //   login();
                      // }
                      //       },
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             'Sign In',
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           Icon(
                      //             Icons.arrow_forward_ios,
                      //             color: Colors.white,
                      //           )
                      //         ],
                      //       )),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? "),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ],
                      )
                    ])),
              ))),
    );
  }
}

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({super.key});

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat(reverse: true);
  late Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: Offset(0, 0.08),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset('assets/clouds.png'),
      SlideTransition(
        position: _animation,
        child: Image.asset('assets/rocket_person.png'),
      ),
    ]);
  }
}
