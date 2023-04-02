import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const darkModeBox = 'darkModeTutorial';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(darkModeBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(darkModeBox).listenable(),
      builder: (context, box, widget) {
        var darkMode = box.get('darkMode', defaultValue: false);
        return MaterialApp(
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Task 8 - Abdul Basit'),
                  Switch(
                    value: darkMode,
                    onChanged: (val) {
                      box.put('darkMode', !darkMode);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
