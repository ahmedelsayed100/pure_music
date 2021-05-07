import 'package:flutter/material.dart';

import 'screens/albums.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pure Music",

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
      ),
      initialRoute: "home",
      // home: Albums(),
      routes: {
        HomeScreen.id: (_) => HomeScreen(),
      },
    );
  }
}
