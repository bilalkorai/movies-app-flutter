import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class forgotp extends StatefulWidget{
  @override
  State<forgotp> createState() => _forgotpState();
}

class _forgotpState extends State<forgotp> {
  forgotpass() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
    }on FirebaseAuthException catch(e){
      Get.snackbar("error", e.code);
    }catch(e){
      Get.snackbar("error", e.toString());
    }
    print("pree");
  }
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top:10, left: 0),
                child: Container(
                    height: 100,
                    width: 150,
                    child: Image.asset("assets/images/11.png")
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  height: 400,
                  width: 500,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left:0, top: 20),
                          child: Text("Reset Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                            child: ElevatedButton(onPressed: (){
                                  forgotpass();
                                  Get.snackbar("Link sent", "check your inbox", backgroundColor: Colors.white);
                            }, child: Text("Send Link"), style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.green, width: 2),backgroundColor: Colors.black,foregroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),)),
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