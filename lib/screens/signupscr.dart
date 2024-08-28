import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pakflix/screens/loginscr.dart';
import 'package:pakflix/screens/splashscr.dart';
class signupscr extends StatefulWidget{
  @override
  State<signupscr> createState() => _signupscrState();
}

class _signupscrState extends State<signupscr> {

  final databaseref = FirebaseDatabase.instance.ref("users");
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  bool isloading = false;

  String encodeEmail(String email) {
    return email.replaceAll('.', ',');
  }
  confirm(){
    if(password.text == confirmpass.text){
      signup();
    }else{
      Get.snackbar("error", "password and confirm password must match", backgroundColor: Colors.white);
    }
    databaseref.child(encodeEmail(email.text)).set({
      'name': name.text,
      'email': email.text
    });
  }
  signup() async{
    setState(() {
      isloading = true;
    });
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
    }on FirebaseAuthException catch(e){
      Get.snackbar("error", e.code, backgroundColor: Colors.white);
    }catch(e){
      Get.snackbar("error", e.toString());
    }
    setState(() {
      isloading = false;
    });
    Get.offAll(str());
  }



  @override
  Widget build(BuildContext context) {
    return isloading ? Center(child: CircularProgressIndicator(),) : Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:30, left: 0),
            child: Container(
                height: 80,
                width: 230,
                child: Image.asset("assets/images/11.png")
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                color: Color(0xfff8fff7),
              ),
              child: ListView(
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left:0, top: 00),
                    child: Center(child: Text("Signup", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: 300,
                    height: 40,
                    child: TextField(
                      controller: name,
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
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.green.shade300, fontSize: 13)
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
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
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: 300,
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
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: 300,
                    height: 40,
                    child: TextField(
                      controller: confirmpass,
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
                          hintText: "Confirm Pasword",
                          hintStyle: TextStyle(color: Colors.green.shade300, fontSize: 13)
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      child: ElevatedButton(onPressed: (()=> confirm()), child: Text("Signup"), style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.green, width: 2),backgroundColor: Colors.black,foregroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),)),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account ", style: TextStyle(color: Colors.grey.shade500),),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginscr()));
                      }, child: Text("Login", style: TextStyle(color: Colors.green),))
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}