// ignore_for_file: unnecessary_getters_setters

class User {
  String? _nome;
  String? _email;
  String? _senha;
  String? _urlImage;
  String? idUsuario;

  User();


  //Converte o objeto usuário em map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome" : nome,
      "email" : email,
    };
    return map;
  } 

  String? get senha => _senha;
  set senha(String value){
    _senha = value;
  }
  String? get email => _email;
  set email(String value){
    _email = value;
  }
  String? get nome => _nome;
  set nome(String value){
    _nome = value;
  }

  String? get urlImage => _urlImage;

  set urlImage(String value) => _urlImage = value;

}