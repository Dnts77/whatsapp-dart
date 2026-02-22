import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//ignore_for_file: unused_field

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final TextEditingController _controllerNome = TextEditingController();
  File? _image;

  Future<void> _imageRecover(String imageOrigin)async{
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(
      source: imageOrigin == "camera" ? ImageSource.camera : ImageSource.gallery,
    );
    
    if(selectedImage != null){
      setState(() {
      _image = File(selectedImage.path);
      });
    }
    
    
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
                  backgroundImage: NetworkImage("https://qsivrzekbkwddqqjdozd.supabase.co/storage/v1/object/sign/perfil/perfil5.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8yODk3ZjE2Yi04NGIxLTRjMzQtOGI4Ny1hOWM3NWNiZTQ1MGMiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwZXJmaWwvcGVyZmlsNS5qcGciLCJpYXQiOjE3NzE3MDM2ODEsImV4cCI6NDI5NDU4MzY4MX0._PVLv5v6xBHwjQ-XIfr2IKtXq7RbMvKCS5mWPMtPz1A"),
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
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 20
                    ),
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