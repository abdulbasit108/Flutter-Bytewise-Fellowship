import 'package:flutter/material.dart';
import 'package:splendid_mart/constants/global_variables.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: GlobalVariables.secondaryColor,
        ),
      ),
    );
  }
}
