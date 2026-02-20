import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        backgroundColor: Color(0xff075e54),
        foregroundColor: Colors.white,
        elevation: 3.5,
        shadowColor: Colors.black,
      ),
      body: Container(),
    );
  }
}