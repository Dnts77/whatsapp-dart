// ignore_for_file: unnecessary_getters_setters
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  late String _idRemetente;
  late String _idDestinatario;
  late String _nome;
  late String _mensagem;
  late String _caminhoFoto;
  late String _tipoMensagem; //texto/imagem

  Chat();

  void salvar() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
     db.collection("conversas")
     .doc(idRemetente)
     .collection("ultima_conversa")
     .doc(idDestinatario)
     .set(toMap());
  }
  
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idRemetente" : _idRemetente,
      "idDestinatario" : _idDestinatario,
      "nome" : _nome,
      "mensagem" : _mensagem,
      "caminhoFoto" : _caminhoFoto,
      "tipoMensagem" : _tipoMensagem,
    };
    return map;
  } 
  
  String get nome => _nome;

 set nome(String value) => _nome = value;

  String get mensagem => _mensagem;

 set mensagem( String value) => _mensagem = value;

  String get caminhoFoto => _caminhoFoto;

 set caminhoFoto( String value) => _caminhoFoto = value;

 String get idRemetente => _idRemetente;
 set idRemetente(String value) => _idRemetente = value;

 String get idDestinatario => _idDestinatario;
 set idDestinatario(String value) => _idDestinatario = value;

 String get tipoMensagem => _tipoMensagem;
 set tipoMensagem(String value) => _tipoMensagem = value;


}