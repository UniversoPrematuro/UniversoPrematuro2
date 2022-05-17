import 'package:flutter/material.dart';
import 'package:universoprematurov8/pages/home.dart';
import 'package:universoprematurov8/pages/register.dart';

import '../pages/login.dart';

class RouteGenerator {

  // static const ROTA_HOME = "/home";
  
  static Route<dynamic> generateRoute(RouteSettings settings){
    
    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
          builder: (_) => const Home()
          );
      case "/login" :
        return MaterialPageRoute(
          builder: (_) => Login()
          );
      case "/register" :
        return MaterialPageRoute(
          builder: (_) => const Register()
          );
      default:
      _erroRota();
    }
    return _erroRota();

  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("Tela não encontrada")),
          body: const Center(
            child: Text("Tela não encontrada"),
          ) ,
        );
      }
    );
  }

}