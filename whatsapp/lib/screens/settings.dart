import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:supabase_flutter/supabase_flutter.dart';
//ignore_for_file: unused_field
//ignore_for_file: unused_import

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final TextEditingController _controllerNome = TextEditingController();
  File? _image;
  String? _loggedUserId;
  dynamic imageUrl;
  

  Future<void> _imageRecover(String imageOrigin)async{
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(
      source: imageOrigin == "camera" ? ImageSource.camera : ImageSource.gallery,
    );
    
    if(selectedImage != null){
      setState(() {
      _image = File(selectedImage.path);
      _imageUpload();
      });
    }
    
    
  }

  Future <void> _imageUpload()async{
    final supabase = Supabase.instance.client;
    final avatarFile = File(_image!.path);
    final String fileName = "$_loggedUserId.jpg";
    
    try {
      await supabase.storage.from("perfil").upload(fileName, avatarFile, fileOptions: const FileOptions(upsert: true));
      setState(() {
        imageUrl = "${supabase.storage.from("perfil").getPublicUrl(fileName)}?t=${DateTime.now().millisecondsSinceEpoch}";
      });
      _updateSupabaseImage(fileName);
    } catch (e) {
      log(e.toString());
    }
  }

  //Vamo ver se funciona
  Future<void> _updateSupabaseImage(String url) async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, dynamic> dataUpdate = {
      "urlImagem" : url
    };
    db.collection("usuarios").doc(_loggedUserId).update(dataUpdate);
    //print("funcionou?");
  }

  Future<void> _updateFirestoreName() async{
    String nome = _controllerNome.text;
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, dynamic> dataUpdate = {
      "nome" : nome
    };
    db.collection("usuarios").doc(_loggedUserId).update(dataUpdate);
    //print("funcionou?");
  }
  

  Future<void> _userDataRecovery() async{
    fb.FirebaseAuth auth = fb.FirebaseAuth.instance;
    fb.User? loggedUser = auth.currentUser;
    if(loggedUser != null){
      setState(() {
        _loggedUserId = loggedUser.uid;
      });
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection("usuarios").doc(_loggedUserId).get();

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    _controllerNome.text = data["nome"];

    if(data["urlImagem"] != null){
      setState(() {
        imageUrl = data["urlImagem"];
      });
      print("Funcionou?");
    }
    }
    
  }

  @override
  void initState() {
    super.initState();
    _userDataRecovery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff075e54),
        foregroundColor: Colors.white,
        title: const Text(
          "Configurações",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Carregando
                CircleAvatar(
                  radius: 100,
                  backgroundImage: imageUrl != null ?
                  NetworkImage(imageUrl) : null,
                  backgroundColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (){
                        _imageRecover("camera");
                      },
                      child: const Text("Câmera")
                    ),
                    TextButton(
                      onPressed: (){
                        _imageRecover("galeria");
                      },
                      child: const Text("Galeria")
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                    /*onChanged: (_){
                      _updateFirestoreName();
                    },*/
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Nome",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35)
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 76, 187, 133),
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                    onPressed: (){
                      _updateFirestoreName();
                    }, 
                    child: const Text(
                      "Salvar",
                      style:  TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}