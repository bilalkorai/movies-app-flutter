import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:pakflix/screens/homescr.dart';
import 'package:pakflix/screens/signupscr.dart';

import 'forgotpassword.dart';

class loginscr extends StatefulWidget{
  @override
  State<loginscr> createState() => _loginscrState();
}

class _loginscrState extends State<loginscr> {
  bool isloading = false;
  login() async{
    setState(() {
      isloading = true;
    });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
    }on FirebaseAuthException catch(e){
      Get.snackbar("error", e.code, backgroundColor: Colors.white);
    }catch(e){
      Get.snackbar("error", e.toString());
    }
    setState(() {
      isloading = false;
    });
  }
  TextEditingController email = TextEditingController();
  TextEditingController password= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return isloading ? Center(child: CircularProgressIndicator(color: Colors.white,),) : Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10, left: 0),
                child: Container(
                  height: 100,
                    width: 150,
                    child: Image.asset("assets/images/11.png")
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  height: 400,

                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left:0, top: 20),
                          child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                          ),
                        SizedBox(height: 30,),
                        Container(
                          width: 240,
                          height: 40,
                          child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)
                              ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green)
                                ),
                              contentPadding: EdgeInsets.symmetric(vertical: 6,horizontal: 15),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.green.shade300, fontSize: 13)
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          width: 240,
                          height: 40,
                          child: TextField(
                            controller: password,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green)
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 6,horizontal: 15),
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.green.shade300, fontSize: 13)
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> forgotp()));
                              }, child: Text("Forgot Password",style: TextStyle(color: Colors.green, fontSize: 13),)),
                            ),
                          ],
                        ),
                        Container(
                          width: 240,
                            child: ElevatedButton(onPressed: (()=>login()), child: Text("Login"), style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.green, width: 2),backgroundColor: Colors.black,foregroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),)),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Not have an account ", style: TextStyle(color: Colors.grey.shade500),),
                            TextButton(onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> signupscr()));
                            }, child: Text("SignUp", style: TextStyle(color: Colors.green),))
                          ],
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}