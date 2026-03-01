import 'package:flutter/material.dart';
import 'package:whatsapp/model/chat.dart';
import 'package:supabase/supabase.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  List<Chat> chatList =[];

  @override
  void initState() {
    super.initState();
    Chat conversa = Chat();
    conversa.nome = "Ana Clara";
    conversa.mensagem = "Fala irmão";
    conversa.caminhoFoto = "https://qsivrzekbkwddqqjdozd.supabase.co/storage/v1/object/sign/perfil/perfil1.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8yODk3ZjE2Yi04NGIxLTRjMzQtOGI4Ny1hOWM3NWNiZTQ1MGMiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZXJmaWwvcGVyZmlsMS5qcGciLCJpYXQiOjE3NzE3MDMzOTQsImV4cCI6NDI5NDU4MzM5NH0.dsXenGhSgIPG2w5wm8NQdl2YfbTqyRSGjWkJlJBZAMc";

    chatList.add(conversa);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatList.length,
      itemBuilder: (context, index){
        Chat conversa = chatList[index];
        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversa.caminhoFoto),
          ),
          title: Text(
            conversa.nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          subtitle: Text(
            conversa.mensagem,
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