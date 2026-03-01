import 'package:flutter/material.dart';
import 'package:whatsapp/model/chat.dart';
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
  FirebaseFirestore db = FirebaseFirestore.instance;

  
  final TextEditingController _controllerMensagem = TextEditingController();
  
  void _sendMessage() {
    String messageText = _controllerMensagem.text;

    if (messageText.isNotEmpty) {
      Message mensagem = Message();

      mensagem.idUsuario = _loggedUserId;
      mensagem.mensagem = messageText;
      mensagem.urlImage = "";
      mensagem.tipo = "texto";
      mensagem.time = DateTime.now();

      _saveMessage(_loggedUserId, _destUserId, mensagem);
      _saveMessage(_destUserId, _loggedUserId, mensagem);
      
      //Salvando conversa
      _saveChat(mensagem);
      
    }
  }

  void _saveChat(Message msg){

    //Salvando pro remetente
    Chat cRemetente = Chat();
    cRemetente.idRemetente = _loggedUserId;
    cRemetente.idDestinatario = _destUserId;
    cRemetente.mensagem = msg.mensagem!;
    cRemetente.nome = widget.contato.nome!;
    cRemetente.caminhoFoto = widget.contato.urlImage!;
    cRemetente.tipoMensagem = msg.tipo!;
    cRemetente.salvar();

    //Salvando pro destinatário
    Chat cDestinatario = Chat();
    cDestinatario.idRemetente = _destUserId;
    cDestinatario.idDestinatario = _loggedUserId;
    cDestinatario.mensagem = msg.mensagem!;
    cDestinatario.nome = widget.contato.nome!;
    cDestinatario.caminhoFoto = widget.contato.urlImage!;
    cDestinatario.tipoMensagem = msg.tipo!;
    cDestinatario.salvar();

  }

  Future<void> _sendPhoto() async{
    //FIXME: Método de enviar foto não é funcional pois Storage é pago
  }

  void _saveMessage(String idRemetente, String idDest, Message msg) async {
    await db
        .collection("mensagens")
        .doc(idRemetente)
        .collection(idDest)
        .add(msg.toMap());

    _controllerMensagem.clear();
  }

  Future<void> _userDataRecovery() async {
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

    var stream = StreamBuilder(
      stream: db
          .collection("mensagens")
          .doc(_loggedUserId)
          .collection(_destUserId)
          .orderBy("time", descending: false)
          .snapshots(),
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
            QuerySnapshot querySnapshot =
                snapshot.data as QuerySnapshot<Object>;
            if (snapshot.hasError) {
              return Expanded(child: Text("Erro ao carregar dados"));
            } else {
              return Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) {

                    List<DocumentSnapshot> mensagens = querySnapshot.docs.toList();
                    DocumentSnapshot item = mensagens[index];

                    double containerWidth = MediaQuery.of(context).size.width * 0.8;
                    Alignment alinhamento = Alignment.centerRight;
                    Color cor = Color(0xffd2ffa5);
                    if (_loggedUserId != item["idUsuario"]) {
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
                          child: Text(
                            item["mensagem"],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: querySnapshot.docs.length,
                ),
              );
            }
        }
      },
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
            child: Column(children: [stream, chatBox]),
          ),
        ),
      ),
    );
  }
}
