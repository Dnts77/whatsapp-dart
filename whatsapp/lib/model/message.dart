class Message {
  String? idUsuario;
  String? _mensagem;
  String? _urlImage;
  String? _tipo;
  DateTime? _time;

   Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUsuario" : idUsuario,
      "mensagem" : mensagem,
      "urlImage" : urlImage,
      "tipo" : _tipo,
      "time" : _time
    };
    return map;
  } 

  String? get mensagem => _mensagem;
  set mensagem( String value) => _mensagem = value;

  String? get urlImage => _urlImage;
  set urlImage( String value) => _urlImage = value;

  String? get tipo => _tipo;
  set tipo( String value) => _tipo = value;
 
  DateTime? get time => _time;
  set time(DateTime value) => _time = value;


  Message();


}