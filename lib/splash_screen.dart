
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/home_screen.dart';
import 'package:firebase_practice/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if(auth!=null){
      Timer(Duration(seconds: 3),(){
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }else{
      Timer(Duration(seconds: 3), (){
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
          child: Text("Splash Screen")),
    );
  }
}