import 'package:flutter/material.dart';
import 'package:whatsapp/model/chat.dart';
import 'package:supabase/supabase.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  List<Chat> chatList = [
    Chat(
      "Ana Clara",
      "Fala irmão",
      "https://qsivrzekbkwddqqjdozd.supabase.co/storage/v1/object/sign/perfil/perfil1.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8yODk3ZjE2Yi04NGIxLTRjMzQtOGI4Ny1hOWM3NWNiZTQ1MGMiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZXJmaWwvcGVyZmlsMS5qcGciLCJpYXQiOjE3NzE3MDMzOTQsImV4cCI6NDI5NDU4MzM5NH0.dsXenGhSgIPG2w5wm8NQdl2YfbTqyRSGjWkJlJBZAMc"
    ),
    
    Chat(
      "Pedro Silva",
      "Me manda o link depois",
      "https://qsivrzekbkwddqqjdozd.supabase.co/storage/v1/object/sign/perfil/perfil2.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8yODk3ZjE2Yi04NGIxLTRjMzQtOGI4Ny1hOWM3NWNiZTQ1MGMiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZXJmaWwvcGVyZmlsMi5qcGciLCJpYXQiOjE3NzE3MDM0NzIsImV4cCI6NDI5NDU4MzQ3Mn0.MgxWJ5aVebRV3r6Uw7_iD4QBMQH8tvODs50KVa0aExs"
    ),
    
    Chat(
      "Marcela Almeida",
      "Vamos fazer o orçamento",
      "https://qsivrzekbkwddqqjdozd.supabase.co/storage/v1/object/sign/perfil/perfil3.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8yODk3ZjE2Yi04NGIxLTRjMzQtOGI4Ny1hOWM3NWNiZTQ1MGMiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZXJmaWwvcGVyZmlsMy5qcGciLCJpYXQiOjE3NzE3MDM1MjcsImV4cCI6MTc3ODYxNTUyN30.oAdiq5z5X9jZoiNrTe0afhdKPCkOYczqK9sl9vtHvBg"
    ),
    
    Chat(
      "José Renato",
      "Ele me mandou o contrato já",
      "https://qsivrzekbkwddqqjdozd.supabase.co/storage/v1/object/sign/perfil/perfil4.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8yODk3ZjE2Yi04NGIxLTRjMzQtOGI4Ny1hOWM3NWNiZTQ1MGMiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZXJmaWwvcGVyZmlsNC5qcGciLCJpYXQiOjE3NzE3MDM2MTksImV4cCI6NDI5NDU4MzYxOX0.zyGWjJ9_744qM4eXtwG5foqQY_wODIbRuA-C8QR4rXU"
    ),
    
    Chat(
      "Jamilton Damasceno",
      "já já o uber chega",
      "https://qsivrzekbkwddqqjdozd.supabase.co/storage/v1/object/sign/perfil/perfil5.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8yODk3ZjE2Yi04NGIxLTRjMzQtOGI4Ny1hOWM3NWNiZTQ1MGMiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZXJmaWwvcGVyZmlsNS5qcGciLCJpYXQiOjE3NzE3MDM2ODEsImV4cCI6NDI5NDU4MzY4MX0._PVLv5v6xBHwjQ-XIfr2IKtXq7RbMvKCS5mWPMtPz1A"
    ),
    
    

  ];

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