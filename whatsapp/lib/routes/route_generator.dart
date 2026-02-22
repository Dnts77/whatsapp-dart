import 'package:flutter/material.dart';
import 'package:whatsapp/home.dart';
import 'package:whatsapp/login_screen.dart';
import 'package:whatsapp/screens/settings.dart';
import 'package:whatsapp/sign_up_screen.dart';


class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => LoginScreen()
        );
      case "/login":
        return MaterialPageRoute(
          builder: (_) => LoginScreen()
        );
      case "/cadastro":
        return MaterialPageRoute(
          builder: (_) => SignUpScreen()
        );
      case "/home":
        return MaterialPageRoute(
          builder: (_) => Home()
        );
      case "/configuracoes":
        return MaterialPageRoute(
          builder: (_) => Settings()
        );
      default:
        return _routeError();
      
    }
    
  }

  static Route<dynamic> _routeError(){
    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text("Tela não encontrada!"),
          ),
          body: Center(
            child: Text("Tela não encontrada!"),
          ),
        );
      }
    );
  }

}