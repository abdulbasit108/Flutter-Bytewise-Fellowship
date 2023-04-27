import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:photo_app/screens/forgot_password_screen/forgot_password_screen.dart';



import '../../utils/utils.dart';
import '../../widget/round_button.dart';
import '../signup_screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool loading = false;
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
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      // utils().toastMessage(value.user!.email.toString());
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => MainScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
              child: Column(children: [
            Container(
              child: Center(
                child: Image.asset("assets/images/logo.jpg"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Text(
                  "Login",
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
                child: Container(
                    child: Text(
                  "Please sign in to continue",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(80, 80, 80, 1.0),
                  ),
                )),
              ),
            ),
            SizedBox(height: 30),
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
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email,
                                color: Colors.white),
                            filled: true,
                            fillColor: Color(0xFF424242),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
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
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Icon(Icons.lock_open, color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Color(0xFF424242),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  RoundButton(
                    title: 'Login',
                    loading: loading,
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        login();
                      }
                      ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(width: 20))));
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text("Forgot Password?")),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text("Create Account")),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPhoneNumber()));
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(50),
                  //         border: Border.all(
                  //             color: Colors.black
                  //         )
                  //     ),
                  //     child: Center(
                  //       child: Text('Login with phone'),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ])),
        ),
      ),
    );
  }
}


// class SignInScreen extends StatefulWidget {
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   bool _isObscure = true;
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 child: Center(
//                   child: Image.asset("assets/images/logo.jpg"),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                       child: Text(
//                     "Login",
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   )),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                       child: Text(
//                     "Please sign in to continue",
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromRGBO(80, 80, 80, 1.0),
//                     ),
//                   )),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(15),
//                 child: TextField(
//                   controller: emailcontroller,
//                   onChanged: (val) {
//                     BlocProvider.of<SignInBloc>(context).add(
//                         SignInTextChangedEvent(emailcontroller.text.trim(),
//                             passwordcontroller.text.trim()));
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Email',
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(15),
//                 child: TextField(
//                   controller: passwordcontroller,
//                   obscureText: _isObscure,
//                   onChanged: (val) {
//                     BlocProvider.of<SignInBloc>(context).add(
//                         SignInTextChangedEvent(emailcontroller.text.trim(),
//                             passwordcontroller.text.trim()));
//                   },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Password',
//                       suffixIcon: IconButton(
//                           icon: Icon(_isObscure
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                           onPressed: () {
//                             setState(() {
//                               _isObscure = !_isObscure;
//                             });
//                           })),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: BlocBuilder<SignInBloc, SignInState>(
//                   builder: (context, state) {
//                     if (state is SignInErrorState) {
//                       return Text(state.errorMessage,
//                           style: TextStyle(color: Colors.red));
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10),
//                 child: BlocBuilder<SignInBloc, SignInState>(
//                     builder: (context, state) {
//                   return ElevatedButton(
//                     child: Text(
//                       "LOGIN",
//                       style: TextStyle(
//                           fontFamily: "Poppins",
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             if (state is SignInValidState) {
//                               if (emailcontroller.text
//                                   .trim()
//                                   .contains("@gmail.com")) {
//                                 return BlocProvider(
//                                   create: (context) => SignInBloc(),
//                                   child: MainScreen(),
//                                 );
//                               } else {
//                                 return BlocProvider(
//                                   create: (context) => SignInBloc(),
//                                   child: SignInScreen(),
//                                 );
//                               }
//                             }
//                             return BlocProvider(
//                               create: (context) => SignInBloc(),
//                               child: SignInScreen(),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromRGBO(100, 73, 116, 1.0),
//                     ),
//                   );
//                 }),
//               ),
//               Center(
//                 child: Container(
//                     padding: EdgeInsets.only(top: 20),
//                     child: Text(
//                       "Forget password?",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromRGBO(80, 80, 80, 1.0),
//                       ),
//                     )),
//               ),
//               Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 Column(children: [
//                   Padding(
//                       padding: EdgeInsets.only(top: 10),
//                       child: Text(
//                         "Don't have an account?",
//                         style: TextStyle(
//                           fontFamily: "Poppins",
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromRGBO(80, 80, 80, 1.0),
//                         ),
//                       ))
//                 ]),
//                 Column(children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 10),
//                     child: TextButton(
//                         child: Text(
//                           "Create Account",
//                           style: TextStyle(
//                             fontFamily: "Poppins",
//                             fontSize: 12,
//                             color: Color.fromRGBO(100, 73, 116, 1.0),
//                           ),
//                         ),
//                         onPressed: () async {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => BlocProvider(
//                                 create: (context) => SignUpBloc(),
//                                 child: SignUpScreen(),
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//                 ]),
//               ]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// } //
