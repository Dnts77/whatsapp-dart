import 'package:flutter/material.dart';
import 'package:whatsapp/model/message.dart';
import 'package:whatsapp/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatefulWidget {
  const Messages(this.contato, {super.key});

  final User contato;

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  late String _loggedUserId;
  late String _destUserId;

  List<String> chatList = [
    "Olá meu amigo, tudo bem?",
    "Tudo ótimo, e cntg?",
    "To bem tbm, ce vai na corrida la?",
    "Não sei ainda",
    "Pq se vc fosse, qria ver se dava pra ir jnt",
    "Posso te confirmar no sábado?",
    "Beleza",
    "Excelente",
    "To ansioso pra essa corrida",
    "Vai ser daora, mt gente",
    "Vai sim",
    "Lembra do carro que eu tinha dito?",
    "Que daora",
  ];
  final TextEditingController _controllerMensagem = TextEditingController();
  void _sendMessage(){
    String messageText = _controllerMensagem.text;

    if (messageText.isNotEmpty) {
      Message mensagem = Message();

      mensagem.idUsuario = _loggedUserId;
      mensagem.mensagem = messageText;
      mensagem.urlImage = "";
      mensagem.tipo = "texto";

      _saveMessage(_loggedUserId, _destUserId, mensagem);
    }
  }
  void _sendPhoto() {}

  void _saveMessage(String idRemetente, String idDest, Message msg) async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("mensagens").doc(idRemetente).collection(idDest).add(msg.toMap());
  }

  Future<void> _userDataRecovery() async{
    fb.FirebaseAuth auth = fb.FirebaseAuth.instance;
    fb.User? loggedUser = auth.currentUser;
    _loggedUserId = loggedUser!.uid;
    _destUserId = widget.contato.idUsuario!;
    
    
  }

  @override
  void initState() {
    _userDataRecovery();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var chatBox = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMensagem,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Digite uma mensagem",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      _sendPhoto();
                    },
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Color(0xff075e54),
            onPressed: () {
              _sendMessage();
            },
            mini: true,
            child: Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );

    var listView = Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          double containerWidth = MediaQuery.of(context).size.width * 0.8;
          Alignment alinhamento = Alignment.centerRight;
          Color cor = Color(0xffd2ffa5);
          if (index % 2 == 0) {
            cor = Colors.white;
            alinhamento = Alignment.centerLeft;
          }

          return Align(
            alignment: alinhamento,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Container(
                width: containerWidth,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(chatList[index], style: TextStyle(fontSize: 18)),
              ),
            ),
          );
        },
        itemCount: chatList.length,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: widget.contato.urlImage != null
                  ? NetworkImage(widget.contato.urlImage!)
                  : null,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(widget.contato.nome!),
            ),
          ],
        ),
        backgroundColor: Color(0xff075e54),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgs/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(children: [listView, chatBox]),
          ),
        ),
      ),
    );
  }
}
