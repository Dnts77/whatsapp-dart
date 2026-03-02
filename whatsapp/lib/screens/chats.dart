import 'dart:async';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  List<Chat> chatList =[];
  final _controller = StreamController<QuerySnapshot>.broadcast();
  FirebaseFirestore db = FirebaseFirestore.instance;
  String? _loggedUserId;

  @override
  void initState() {
    super.initState();
    _userDataRecovery();
    Chat conversa = Chat();
    conversa.nome = "Ana Clara";
    conversa.mensagem = "Fala irmão";
    conversa.caminhoFoto = "https://qsivrzekbkwddqqjdozd.supabase.co/storage/v1/object/sign/perfil/perfil1.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8yODk3ZjE2Yi04NGIxLTRjMzQtOGI4Ny1hOWM3NWNiZTQ1MGMiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZXJmaWwvcGVyZmlsMS5qcGciLCJpYXQiOjE3NzE3MDMzOTQsImV4cCI6NDI5NDU4MzM5NH0.dsXenGhSgIPG2w5wm8NQdl2YfbTqyRSGjWkJlJBZAMc";

    chatList.add(conversa);
  }

  Stream<QuerySnapshot> _addChatsListener(){
    final stream = db.collection("conversas")
    .doc(_loggedUserId)
    .collection("ultima_conversa")
    .snapshots();

    stream.listen((dados){
      _controller.add(dados);
    });
    
    return stream;
  }

  Future<void> _userDataRecovery() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? loggedUser = auth.currentUser;
    _loggedUserId = loggedUser!.uid;

    _addChatsListener();
    
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: [
                  Text("Carregando conversas..."),
                  CircularProgressIndicator(),
                ],
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError){
              return Text("Erro ao carregar dados");
            }
            else{
              QuerySnapshot querySnapshot = snapshot.data!;
              if(querySnapshot.docs.isEmpty){
                return Center(
                  child: Text(
                  "Você ainda não possui mensagens",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                );
              }
              return ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context, index){

                List<DocumentSnapshot> conversas = querySnapshot.docs.toList();
                DocumentSnapshot item = conversas[index];
                String? urlImagem = item["caminhoFoto"];
                String mensagem = item["mensagem"];
                String nome = item["nome"];
                  
                  return ListTile(
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: urlImagem != null ? NetworkImage(urlImagem)
                    : null,
                  ),
                  title: Text(
                  nome,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                subtitle: Text(
                 mensagem,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                )
              ),
            );
          }
        );
      }
    }
  }
);


    
  }
}