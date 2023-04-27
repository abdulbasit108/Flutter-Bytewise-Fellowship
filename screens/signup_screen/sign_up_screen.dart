import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../../utils/utils.dart';
import '../../widget/round_button.dart';
import '../signin_screen/signin_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      fireStore.doc(id).set({
        'email': emailController.text.trim(),
        'name': nameController.text.trim(),
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          // Container(
          //   child: Center(
          //     child: Image.asset("assets/images/logo.jpg"),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Text(
                "CREATE ACCOUNT",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF424242),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Full Name';
                          }
                          return null;
                        },
                      ),
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
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color(0xFF424242),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color(0xFF424242),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color(0xFF424242),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Re-Enter Password';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                RoundButton(
                  title: 'Sign up',
                  loading: loading,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      signUp();
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ])));
  }
}
// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   bool _isObscure = true;
//   TextEditingController namecontroller = TextEditingController();
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   TextEditingController confirmpasswordcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               child: Center(
//                 child: Image.asset("assets/images/logo.jpg"),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 20),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                     child: Text(
//                   "Create Account",
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 )),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: TextField(
//                 controller: namecontroller,
//                 onChanged: (value) {
//                   BlocProvider.of<SignUpBloc>(context).add(
//                       SignUpTextChangedEvent(
//                           namecontroller.text.trim(),
//                           emailcontroller.text.trim(),
//                           passwordcontroller.text.trim(),
//                           confirmpasswordcontroller.text.trim()));
//                 },
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Full Name',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: TextField(
//                 controller: emailcontroller,
//                 onChanged: (value) {
//                   BlocProvider.of<SignUpBloc>(context).add(
//                       SignUpTextChangedEvent(
//                           namecontroller.text.trim(),
//                           emailcontroller.text.trim(),
//                           passwordcontroller.text.trim(),
//                           confirmpasswordcontroller.text.trim()));
//                 },
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Email',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: TextField(
//                 controller: passwordcontroller,
//                 obscureText: _isObscure,
//                 onChanged: (value) {
//                   BlocProvider.of<SignUpBloc>(context).add(
//                       SignUpTextChangedEvent(
//                           namecontroller.text.trim(),
//                           emailcontroller.text.trim(),
//                           passwordcontroller.text.trim(),
//                           confirmpasswordcontroller.text.trim()));
//                 },
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                     suffixIcon: IconButton(
//                         icon: Icon(_isObscure
//                             ? Icons.visibility
//                             : Icons.visibility_off),
//                         onPressed: () {
//                           setState(() {
//                             _isObscure = !_isObscure;
//                           });
//                         })),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: TextField(
//                 controller: confirmpasswordcontroller,
//                 obscureText: _isObscure,
//                 onChanged: (value) {
//                   BlocProvider.of<SignUpBloc>(context).add(
//                       SignUpTextChangedEvent(
//                           namecontroller.text.trim(),
//                           emailcontroller.text.trim(),
//                           passwordcontroller.text.trim(),
//                           confirmpasswordcontroller.text.trim()));
//                 },
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Confirm Password',
//                     suffixIcon: IconButton(
//                         icon: Icon(_isObscure
//                             ? Icons.visibility
//                             : Icons.visibility_off),
//                         onPressed: () {
//                           setState(() {
//                             _isObscure = !_isObscure;
//                           });
//                         })),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: BlocBuilder<SignUpBloc, SignUpState>(
//                 builder: (context, state) {
//                   if (state is SignUpErrorState) {
//                     return Text(state.error,
//                         style: TextStyle(color: Colors.red));
//                   } else {
//                     return Container();
//                   }
//                 },
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 10),
//               child: BlocBuilder<SignUpBloc, SignUpState>(
//                   builder: (context, state) {
//                 return ElevatedButton(
//                   child: Text(
//                     "SIGN UP",
//                     style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   onPressed: () {
//                     if (state is SignUpValidState) {
//                       Navigator.pushReplacementNamed(context, "/SignIn");
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromRGBO(100, 73, 116, 1.0),
//                   ),
//                 );
//               }),
//             ),
//             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Column(children: [
//                 Padding(
//                     padding: EdgeInsets.only(top: 10),
//                     child: Text(
//                       "Already have an account?",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromRGBO(80, 80, 80, 1.0),
//                       ),
//                     ))
//               ]),
//               Column(children: [
//                 Padding(
//                     padding: EdgeInsets.only(top: 10),
//                     child: TextButton(
//                       child: Text(
//                         "Sign in",
//                         style: TextStyle(
//                           fontFamily: "Poppins",
//                           fontSize: 12,
//                           color: Color.fromRGBO(100, 73, 116, 1.0),
//                         ),
//                       ),
//                       onPressed: () async {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => BlocProvider(
//                                       create: (context) => SignInBloc(),
//                                       child: SignInScreen(),
//                                     )));
//                       },
//                     ))
//               ])
//             ])
//           ],
//         ),
//       ),
//     ));
//   }
// }
