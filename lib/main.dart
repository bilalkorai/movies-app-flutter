

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pakflix/screens/splashscr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pakflix/toggletheme/toggle_theme.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => themechanger(),
    child: myapp(),
  ));
}

class myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "pak flix",
      theme: ThemeData.light(),
      home: splashscr(),
    );
  }
}