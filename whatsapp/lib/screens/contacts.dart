//ignore_for_file: unused_import
//ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/model/chat.dart';
import 'package:whatsapp/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_user;

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  String? _loggedUserId;
  String? _loggedUserEmail;

  Future<List<User>> _contactsRecovery() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection("usuarios").get();

    List<User> usersList = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data() as Map<String, dynamic>;
      if(dados["email"] == _loggedUserEmail) continue; //continue faz o parâmetro ser passado
      User usuario = User();
      usuario.email = dados["email"] ?? "";
      usuario.nome = dados["nome"] ?? "Sem nome";
      usuario.urlImage = dados["urlImagem"] ?? "";

      usersList.add(usuario);
    }
    return usersList;
  }

  Future<void> _userDataRecovery() async {
    firebase_user.FirebaseAuth auth = firebase_user.FirebaseAuth.instance;
    firebase_user.User? loggedUser = auth.currentUser;
    _loggedUserId = loggedUser!.uid;
    _loggedUserEmail = loggedUser.email;
    
  }

  @override
  void initState() {
    super.initState();
    _userDataRecovery();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _contactsRecovery(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: [
                  Text("Carregando Contatos..."),
                  CircularProgressIndicator(),
                ],
              ),
            );

          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasError){
              return Text("Erro ao carregar dados: ${snapshot.error}");
            }
            if(!snapshot.hasData || snapshot.data == null){
              return Text("Nenhum dado encontrado");
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                List<User> itensList = snapshot.data!;
                User usuario = itensList[index];
                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: usuario.urlImage != null
                        ? NetworkImage(usuario.urlImage!)
                        : null,
                  ),
                  title: Text(
                    usuario.nome!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
