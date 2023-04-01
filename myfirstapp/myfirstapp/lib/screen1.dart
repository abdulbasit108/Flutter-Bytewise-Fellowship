import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myfirstapp/sign_up.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Koderz Kombat'),
      //   backgroundColor: const Color.fromARGB(255, 40, 100, 42),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text(
                      'Task 7 - Abdul Basit\n',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: const Color.fromARGB(255, 40, 100, 42),
                    expandedHeight: 200.0,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset('assets/images/flutter.png',
                          fit: BoxFit.none),
                    ),
                  ),
                  SliverFixedExtentList(
                    itemExtent: 150.0,
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          color: Colors.black,
                          child: const Center(
                            child: Text(
                              "SCROLL ME",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 40, 100, 42),
                                  fontSize: 30),
                            ),
                          ),
                        ),
                        Container(color: Color.fromARGB(255, 40, 100, 42)),
                        Container(color: Colors.black),
                        Container(color: Color.fromARGB(255, 40, 100, 42)),
                        Container(color: Colors.black),
                        Container(color: Color.fromARGB(255, 40, 100, 42)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Tooltip(
              message: "Go Back to Log In",
              triggerMode: TooltipTriggerMode.longPress,
              child: TextButton(
                onPressed: () {
                  context.go("/");
                },
                // onLongPress: () {},
                child: Text(
                  'Variable Font Button',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.recursive(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 40, 100, 42),
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 9,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
