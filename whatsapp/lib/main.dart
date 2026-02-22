//ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:whatsapp/login_screen.dart';
import 'package:whatsapp/routes/route_generator.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  

  await Supabase.initialize(url: "https://qsivrzekbkwddqqjdozd.supabase.co", anonKey: "sb_publishable_FM6JYiOl-q4U4_VuxoQ-Ow_-xW_QckO"); //Funciona pelo amor de Deus

  runApp(MaterialApp(
    home: LoginScreen(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff075e54), secondary: Color(0xff25d366))
    ),
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
