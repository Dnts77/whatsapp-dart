// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/home.dart';
import 'package:whatsapp/model/user.dart' as user_model;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  //Controladores Nome/Email/Senha
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  String _errorMessage = "";


  //Validando as credenciais do usuário
  void _validateFields(){
    String nome = _controllerNome.text;
    String senha = _controllerSenha.text;
    String email = _controllerEmail.text;

    if (nome.isNotEmpty) {
      
      if(email.contains("@") && email.isNotEmpty){
        
        if (senha.isNotEmpty && senha.length > 6) {
          setState(() {
            _errorMessage = "";
          });
          user_model.User usuario = user_model.User();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          
          _userSignUp(usuario);
        }
        else{
          setState(() {
            _errorMessage = "Preencha a senha";
          });
        }

      }else{
        setState(() {
          _errorMessage = "Preencha o e-mail corretamente";
        });
      }

    } else {
      setState(() {
        _errorMessage = "Preencha o nome";
      });
    }


  }


  //Cadastrando o usuário
  void _userSignUp( user_model.User usuario){
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha
    ).then((firebaseUser) {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => Home()
        )
      );
    }).catchError((error){
      setState(() {
        _errorMessage = "Erro ao cadastrar usuário, verifique e tente novamente!";
      }); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.5,
        shadowColor: Colors.black,
        title: Text("Cadastro"),
        centerTitle: true,
        backgroundColor: Color(0xff075e54),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff075e54)
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "assets/imgs/usuario.png", 
                    width: 200, 
                    height: 150,
                  )
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
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35)
                      )
                    ),
                  ),
                ),
                TextField(
                    controller: _controllerSenha,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Senha",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35)
                      )
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                    onPressed: (){
                      _validateFields();
                    }, 
                    child: const Text(
                      "Cadastrar",
                      style:  TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    
                  )
                ),
                Center(
                  child: Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20
                    )
                  ),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}