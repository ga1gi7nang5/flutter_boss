import 'package:flutter/material.dart';

import 'package:flutter_boss/pages/splash_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boss直聘',
      theme: ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        primaryColor: new Color.fromARGB(255, 55, 194, 188),
        accentColor: Colors.cyan[300],
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
