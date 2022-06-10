import 'package:flutter/material.dart';
import 'package:universoprematurov8/pages/desenvolvimento/dev_home.dart';
import '../pages/desenvolvimento/tasks/task_1.dart';
import '../pages/desenvolvimento/tasks/task_2.dart';
import '/pages/home.dart';
import '/pages/register.dart';

import '../pages/edit_profile.dart';
import '../pages/login.dart';
import '../pages/nav.dart';
import '../pages/profile.dart';
import '../pages/resetpass.dart';

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
          builder: (_) => const Login()
          );
      case "/register" :
        return MaterialPageRoute(
          builder: (_) => const Register()
          );
      case "/profile" :
        return MaterialPageRoute(
          builder: (_) => const Profile()
          );
      case "/editprofile" :
        return MaterialPageRoute(
          builder: (_) =>  const EditProfile()
          );
      case "/nav" : 
        return MaterialPageRoute(
          builder:(_) =>  const Nav(),
        );
      case "/resetpassword" : 
        return MaterialPageRoute(
          builder:(_) => const ResetPassword(),
        );
      case "/desenvolvimento" : 
        return MaterialPageRoute(
          builder:(_) => Desenvolvimento(),
        );
      case "/taskone" : 
        return MaterialPageRoute(
          builder:(_) => TaskOne(),
        );
      case "/tasktwo" : 
        return MaterialPageRoute(
          builder:(_) => TaskTwo(),
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