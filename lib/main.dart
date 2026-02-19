//ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:whatsapp/login_screen.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseFirestore.instance.collection("usuarios").doc("001").set({"nome" : "Jamilton"});


  runApp(MaterialApp(
    home: LoginScreen(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff075e54), secondary: Color(0xff25d366))
    ),
    debugShowCheckedModeBanner: false,
  ));
}
