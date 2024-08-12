
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pakflix/screens/homescr.dart';
import 'package:pakflix/screens/signupscr.dart';

import 'loginscr.dart';

class splashscr extends StatefulWidget{
  @override
  State<splashscr> createState() => _splashscrState();
}

class _splashscrState extends State<splashscr> {
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> str()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("assets/animations/Untitled_file.json", height: 400, width: 400),
          ),
        ],
      ),
    );
  }
}

Widget str(){
  return StreamBuilder(
      stream:FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return homescr();
        }else{
          return loginscr();
        }
      });
}
