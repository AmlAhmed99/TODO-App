import 'package:flutter/material.dart';
import 'package:todo_app/layout/HomeScreen.dart';
import 'package:todo_app/modules/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        homeScreen.homeScreenRoute:(context)=>homeScreen(),
        SplashScreen.SplashScreenRoute:(context)=>SplashScreen(),
      },
      initialRoute: SplashScreen.SplashScreenRoute,
    );
  }
}
