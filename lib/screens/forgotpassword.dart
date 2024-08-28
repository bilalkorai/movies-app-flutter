import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(top:10, left: 0),
            child: Container(
                height: 50,
                width: 100,
                child: Image.asset("assets/images/11.png")
            ),
          ),
          SizedBox(height: 40,),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                color: Color(0xfff8fff7),
              ),
              child: ListView(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left:0, top: 20),
                    child: Center(child: Text("Reset Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)),
                  ),
                  SizedBox(height: 60,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: 300,
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      child: ElevatedButton(onPressed: (){
                            forgotpass();
                            Get.snackbar("Link sent", "check your inbox", backgroundColor: Colors.white);
                      }, child: Text("Send Link"), style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.green, width: 2),backgroundColor: Colors.black,foregroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}