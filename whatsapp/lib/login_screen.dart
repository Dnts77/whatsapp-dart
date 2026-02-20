import 'package:flutter/material.dart';
import 'package:whatsapp/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "assets/imgs/logo.png", 
                    width: 200, 
                    height: 150,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
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
                    onPressed: (){}, 
                    child: const Text(
                      "Entrar",
                      style:  TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    
                  )
                ),
                Center(
                  child: GestureDetector(
                    child: const Text(
                      "Não tem conta? Cadastre-se!",
                      style: TextStyle(color: Colors.white)
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
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