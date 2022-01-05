
import 'dart:async';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:todo_app/layout/HomeScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String SplashScreenRoute='SplashScreenRoute';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacementNamed(context, homeScreen.homeScreenRoute);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/todo.png',height: 180,),
              SizedBox(height: 50,),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(
                    105, 166, 220, 1.0)),
              )

            ],
          ),
        ),
      ),
    );
  }
}

