import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _emailUsuario = "";

  Future<void> _recuperarEmail() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? loggedUser = await auth.currentUser;

    setState(() {
      _emailUsuario = loggedUser!.email.toString();
    });
  }

  @override
  void initState(){
    _recuperarEmail();
    super.initState();
  }

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
      body: Container(
        child: Text(_emailUsuario),
      ),
    );
  }
}