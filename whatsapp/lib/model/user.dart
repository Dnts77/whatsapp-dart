// ignore_for_file: unnecessary_getters_setters

class User {
  late String _nome;
  late String _email;
  late String _senha;

  User();


  //Converte o objeto usuário em map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome" : nome,
      "email" : email,
    };
    return map;
  } 

  String get senha => _senha;
  set senha(String value){
    _senha = value;
  }
  String get email => _email;
  set email(String value){
    _email = value;
  }
  String get nome => _nome;
  set nome(String value){
    _nome = value;
  }

}