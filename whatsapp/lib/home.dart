// ignore_for_file: await_only_futures
import 'package:whatsapp/screens/chats.dart';
import 'package:whatsapp/screens/contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  String _emailUsuario = "";

  TabController? _tabController;

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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp",style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xff075e54),
        foregroundColor: Colors.white,
        elevation: 3.5,
        shadowColor: Colors.black,
        bottom:  TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            const Text("Conversas", style: TextStyle(color: Colors.white),),
            const Text("Contatos", style: TextStyle(color: Colors.white))
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Chats(),
          Contacts()
        ],
      ),
    );
  }
}